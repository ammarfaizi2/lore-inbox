Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVJVS13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVJVS13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJVS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 14:27:29 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:48854 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751096AbVJVS12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 14:27:28 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: spitz (zaurus sl-c3000) support
To: Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>,
       lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sat, 22 Oct 2005 20:27:22 +0200
References: <4WXqB-7X5-35@gated-at.bofh.it> <4WY3e-vQ-17@gated-at.bofh.it> <4WYwf-14j-9@gated-at.bofh.it> <4X6Nd-4LV-29@gated-at.bofh.it> <4Xk3R-8an-25@gated-at.bofh.it> <4Xkn5-jl-5@gated-at.bofh.it> <4YURv-1sX-1@gated-at.bofh.it> <50s4O-7HJ-9@gated-at.bofh.it> <50sxP-8vu-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ETO5T-0001zK-Ds@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> RPSRC=http://www.rpsys.net/openzaurus/patches

> for A in pxa_i2c_fixes-r0.patch pxa_ohci_platform-r1.patch
[...]
> mmc_timeout-r0.patch pxa_cf_initorder_hack-r1.patch; do
> #       wget $RPSRC/$A
>     cat /data/l/zaurus/spitz.patches/$A | cg-patch
>     pshell
> done
> 
> .... but that's ather poor trick. Few patches broke the download (slow
> line here), and few of them broke compilation later...

To get around the download issues, you can use a Makefile. I do the same
in http://7eggert.dyndns.org/l/netpbmhelp.tar.gz (2.6 KB)

If your download breaks in the middle of the process, you may need to use a
temporary name and rename the complete file after downloading.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
