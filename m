Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTIZO1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTIZO03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:26:29 -0400
Received: from main.gmane.org ([80.91.224.249]:47256 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262288AbTIZO0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:26:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Fri, 26 Sep 2003 16:07:11 +0200
Message-ID: <yw1x3cejlk34.fsf@users.sourceforge.net>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:NpavqFYGiWXjqulhQVG20Ayzghg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mhf@linuxmail.org> writes:

> Suspect chipset related issue which should be looked into.

That's what someone told me three months ago, too.  Nothing happened,
though.

> You could try setting udma mode with hdparm -Xudma[12345] and see
> if it helps.  

That's the first thing I try when things go wrong.  It didn't help
this time.

> I use from a script on startup 
>
> sync
> hdparm -S 255 -K1 -c3 -Xudma5 /dev/hda.

I already tried all most combinations.  The only thing that helps is
-d0, if you can call that help.

> Note: IME, hdparm should not be used when there is substantial 
> disk activity.

I've noticed.  It usually causes the system too freeze for a minute or
so.

I'm a little frustrated at not being able copy large files without
considerable trouble.

-- 
Måns Rullgård
mru@users.sf.net

