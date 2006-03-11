Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752096AbWCKKIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWCKKIm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 05:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCKKIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 05:08:42 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:45791 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1752096AbWCKKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 05:08:41 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
To: Duncan Sands <duncan.sands@math.u-psud.fr>,
       Roland Scheidegger <rscheidegger_lists@hispeed.ch>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 11 Mar 2006 11:08:25 +0100
References: <5NpZk-7wW-13@gated-at.bofh.it> <5NJ1x-1OE-15@gated-at.bofh.it> <5NPJk-3GD-3@gated-at.bofh.it> <5NRBv-6ze-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FI11O-0000bK-8u@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

>> The bttv driver/chip seems to cause random memory corruption sometimes,
>> processes will just start dying...
> 
> There is a known buffer overflow in the bttv driver (when using
> grabdisplay).  The fix is waiting on an audit of the rest of the
> bttv (and similar) code, since it looks like the same mistake
> occurs in several places.

Can you give me a hint on where exactly to shoot at? I'n still hoping it's
not my VIA board giving me trouble (corrupting the first four bytes of a
semi-random page).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
