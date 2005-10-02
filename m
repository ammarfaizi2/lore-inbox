Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJBRI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJBRI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJBRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:08:58 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:1925 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751131AbVJBRI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:08:57 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: A possible idea for Linux: Save running programs to disk
To: Bernard Blackham <bernard@blackham.com.au>, Ed Tomlinson <tomlins@cam.org>,
       lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 02 Oct 2005 19:08:43 +0200
References: <4SXfo-7hM-9@gated-at.bofh.it> <4T47e-5E-1@gated-at.bofh.it> <4TbLq-2VG-5@gated-at.bofh.it> <4TcR9-4sS-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EM7KO-00014G-CK@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Blackham <bernard@blackham.com.au> wrote:
> On Sun, Oct 02, 2005 at 08:57:26AM -0400, Ed Tomlinson wrote:

>> Is there any kernel api that adding would make cryopid more
>> dependable/cleaner?
> 
> Currently a fair bit of information is obtained by injecting code
> into the process's memory space, executing it, and reaping out the
> results (eg, termcaps, file offsets, fcntl states, locks, signal
> actions, etc).  Can't think of ways to make it cleaner off the top
> of my head, but I'm open to ideas.

What about using an uml wrapper + vncserver? This would give you a complete
virtual environment, and if you can make uml suspend-to-disk, you've got
most of it. (I admit I never tried uml, so this is just a guess.)
Off cause the network connections will still time out etc etc, but that's
nothing you can do about that.

Be fvzcyl hfr bcren, juvpu pna fnsr vg'f bja fgngr.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
