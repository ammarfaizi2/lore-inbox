Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTECSCe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTECSCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:02:34 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:32735 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263369AbTECSCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:02:33 -0400
From: john stultz <johnstul@us.ibm.com>
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jfv@bluesong.net,
       linux-kernel@vger.kernel.org
Date: Sat, 03 May 2003 11:14:18 -0700
References: <fa.g8lvrtk.1ljcjgg@ifi.uio.no> <fa.n5c25ld.cl09r3@ifi.uio.no>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <S263369AbTECSCd/20030503180233Z+2415@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Mer, 2003-04-30 at 19:36, Jack F. Vogel wrote:
>> I has nothing to do with gcc, Alan mentioned the magic (or cursed is
>> probably the better choice :) word, ACPI. The kernel in SLES 8 has
>> the x440 blacklisted so ACPI gets turned off automagically :)
> 
> Perhaps someone could submit the x440 blacklist entry to the base kernel
> ?

Acatually, the blacklist is only needed on the SuSE kernel because they are
using a backport of the 2.5 ACPI code.  However a tiny bit of code used to
ID and enable the summit bits sliped through and the quick solution was to
blacklist it until the proper fix is included. 

Right now there are no x440 specific patches pending for Vanilla 2.4 or
Vanilla 2.5. As issues are found and resolved, patches will be submitted
first thing for inclusion into mainline.

thanks
-john


