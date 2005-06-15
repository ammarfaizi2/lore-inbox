Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFOO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFOO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFOO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:58:25 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:22678 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261155AbVFOO5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:57:45 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: .../asm-i386/bitops.h  performance improvements
To: Gene Heskett <gene.heskett@verizon.net>, cutaway@bellsouth.net,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 15 Jun 2005 16:57:28 +0200
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:

>>leal (%%edx,%%edi,8),%%edx
>>
> To what cpu families does this apply?  eg, this may be true for intel,
> but what about amd, via etc?

lea is an 8086 instruction. All clones have it in it's basic form. However,
the multiplicator is not documented for i486, therefore it will be a i586
extension.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
