Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTEWRwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTEWRwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:52:42 -0400
Received: from khms.westfalen.de ([62.153.201.243]:14213 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S264111AbTEWRwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:52:40 -0400
Date: 23 May 2003 20:02:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8mRUVSAXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
Subject: Re: [patch?] truncate and timestamps
X-Mailer: CrossPoint v3.12d.kh11 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 22.05.03 in <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>:

> On Fri, 23 May 2003 Andries.Brouwer@cwi.nl wrote:
> >
> > On the other hand, my question was really a different one:
> > do we want to follow POSIX, also in the silly requirement
> > that truncate only sets mtime when the size changes, while
> > O_TRUNC and ftruncate always set mtime.
>
> Does POSIX really say that? What a crock.

That's why POSIX says no such thing.

What it *does* say is

  Upon successful completion, if fildes refers to a regular file, the
  ftruncate() function shall mark for update the st_ctime and st_mtime
  fields of the file and the S_ISUID and S_ISGID bits of the file mode may
  be cleared. If the ftruncate() function is unsuccessful, the file is
  unaffected.

See:

   http://www.opengroup.org/onlinepubs/007904975/functions/ftruncate.html

Is it really so hard to look it up that we need to spout FUD instead?

MfG Kai
