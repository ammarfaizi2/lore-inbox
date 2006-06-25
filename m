Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWFYXaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWFYXaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFYXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:30:21 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:17862 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751374AbWFYXaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:30:20 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Kernelsources writeable for everyone?!
To: artusemrys@sbcglobal.net, oshua Hudson <joshudson@gmail.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 26 Jun 2006 01:29:21 +0200
References: <6rkK4-7Do-1@gated-at.bofh.it> <6rkTT-7OS-23@gated-at.bofh.it> <6rrsb-vZ-5@gated-at.bofh.it> <6rvFs-6xp-3@gated-at.bofh.it> <6rJ5L-1n7-3@gated-at.bofh.it> <6rL7C-4oS-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1Fue2x-0001bp-12@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost <artusemrys@sbcglobal.net> wrote:
> Joshua Hudson wrote:

>> I feel like asking how they initially get set to world-writable. To me
>> it means that the tree that is being tarred up for distribution is
>> world-writible. I sure hope that it is a single-user box.
>> -
> 
> Yeah.  Having said, "Take advice", I'm also curious as to just the
> why/how of the current configuration and the work patterns that create
> it.  I get the impression that there *is* a reason for it, because if it
> were just a security issue, I can't see this much resistance to changing
> it.  Sane tar permissions and sensible usage aside.

The reason is the same for which an application SHOULD NOT impose stricter
permissions than 0666 without a reasonon open/create: It's supposed to
honor the umask, imposing a restriction is none of it's busines.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
