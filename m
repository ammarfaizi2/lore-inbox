Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHaMgP>; Sat, 31 Aug 2002 08:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHaMgP>; Sat, 31 Aug 2002 08:36:15 -0400
Received: from khms.westfalen.de ([62.153.201.243]:5782 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317458AbSHaMgO>; Sat, 31 Aug 2002 08:36:14 -0400
Date: 31 Aug 2002 14:02:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-fsdevel@vger.kernel.org
cc: dmccr@us.ibm.com
cc: linux-kernel@vger.kernel.org
cc: trond.myklebust@fys.uio.no
Message-ID: <8Vuk51-mw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 30.08.02 in <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com>:

> One thing that may be interesting (I certainly think it migth be), would
> be to add a "struct user_struct *" pointer to the vfs_cred as well. This
> is because I'd just _love_ to have that "user_struct" fed down to the VFS
> layer, since I think that is where we may some day want to put things like
> user-supplied cryptographic keys etc.
>
> The advantage of "struct user_struct" (as opposed to just a uid_t) is that
> it can have information that lives for the whole duration of a login, and
> it's really the only kind of data structure in the kernel that can track
> that kind of information.

In that case, wouldn't "struct session" be a better name?

MfG Kai
