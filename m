Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbUKVTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUKVTFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUKVTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:03:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62369 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262263AbUKVTCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:02:32 -0500
Date: Mon, 22 Nov 2004 20:02:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
In-Reply-To: <200411220721.26712.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.53.0411222001040.21595@yvahk01.tjqt.qr>
References: <200411212045.51606.gene.heskett@verizon.net>
 <Pine.LNX.4.53.0411220932370.12534@yvahk01.tjqt.qr>
 <200411220721.26712.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Silly Q of the day probably, but what do I set in a Makefile for
>>> the -march=option for building on a 233 mhz Pentium 2?
>>
>>Now that's really stupid, but here's the answer:
>>
>>You run `make menuconfig` (or whichever you like) and choose
>> Processor Type "Pentium II".
>
>If I was building a kernel, then yes my question was stupid.
>
>Except I'm not building a kernel, I'm tryng to compile a module to
>drive some truely dumb hardware, reusing code that was last touched
>[...]

Well, take a fresh kernel tree, set the desired CPU type, and then look at the
.config which is generated. Voilà -- in theory ;-)

>Yeah, I'm stupid.  Virtually all of my original C coding has been done
>on much smaller architectures, and 15 to 20 years ago.  Terminal rust

Never hurts trying to compile a 2.6 for 386SX if the will is strong. :-)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
