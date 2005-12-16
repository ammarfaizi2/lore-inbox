Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVLPLGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVLPLGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVLPLGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:06:47 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:19124 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750875AbVLPLGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:06:46 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Kyle Moffett <mrmacman_g4@mac.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Alex Davis <alex14641@yahoo.com>
Reply-To: 7eggert@gmx.de
Date: Fri, 16 Dec 2005 12:05:18 +0100
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EnDOo-0006Gd-Na@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> Enough already!  These concerns have been raised already, and found
> to be insufficient.  There are several points:
> 
> 1)    ndiswrapper is broken already, and works sheerly by luck anyways;
> NT stacks are 12kb, so you're already asking for stack overflows by
> using it.
> 2)    ndiswrapper encourages use of binary drivers instead of the open-
> source ones that need the testers, so you're only hurting yourselves
> in the long run.

ACK. So where is the driver for the Netgear WG511 Softmac card I'm supposed
to test? I bought this card because it was labled as being supported, and it
turned out that it wasn't, and just nobody cared to update the list of
supported cards with the warning about the unsupported variant.

> 3)    All the in-kernel problems have been fixed, and this makes a lot
> of stuff less fragmentation-prone and more reliable.

BTW: Is there any bug report related to 8K stacks?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
