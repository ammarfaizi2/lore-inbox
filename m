Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319518AbSH3JWQ>; Fri, 30 Aug 2002 05:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319520AbSH3JWP>; Fri, 30 Aug 2002 05:22:15 -0400
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:44231 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S319518AbSH3JWP>; Fri, 30 Aug 2002 05:22:15 -0400
Message-Id: <200208300926.g7U9Qa305884@x06.informatik.uni-bremen.de>
To: Padraig Brady <padraig.brady@corvil.com>
From: Moritz Muehlenhoff <jmm@Informatik.Uni-Bremen.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard freezes on SIS630 based Clevo notebooks
In-Reply-To: <3D6F34AE.7040603@corvil.com>
References: <20020829190533.GA11223@informatik.uni-bremen.de> <3D6F34AE.7040603@corvil.com>
Date: Fri, 30 Aug 2002 11:26:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In stuga.ml.linux.kernel, you wrote:
>> I own a SIS630 based notebook from Baycom (model name "Worldbook II"), which
>> indeed is a rebrand from a Clevo/Kapok model (normal model name 2700C).
>> 
>> I'm experiencing occasional, unreproducable keyboard lockups.
> 
> Me too (2700).
> 
> If noticed the lockups occur when the "battery low"
> light starts flashing. I.E. it's realted to some
> APM event. Also the mouse is unresponsive for me
> when this happens.

There were some lockups when I connected the AC plug, but these
were rare and totally irreproducable as well.
Alan had the same idea as you and gave me the hint to rebuild
the kernel without APM and APIC. I'm running this configuration
since two hours and I'll see if it works a whole week without
freezes. Maybe you can do the same to eliminate statistical
errors.
