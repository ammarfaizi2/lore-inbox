Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSEVMus>; Wed, 22 May 2002 08:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSEVMur>; Wed, 22 May 2002 08:50:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313125AbSEVMuq>; Wed, 22 May 2002 08:50:46 -0400
Subject: Re: [PATCH] SLC82C105 IDE driver: missing __init
To: pazke@orbita1.ru (Andrey Panin)
Date: Wed, 22 May 2002 14:10:06 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522091648.GB312@pazke.ipt> from "Andrey Panin" at May 22, 2002 01:16:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVsU-0001aF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> slc82c105_bridge_revision() functions lacks __init modifier.
> Attached patch (against 2.5.17) fixes it.
> Compiles, but untested. Please consider applying.

I wouldnt get too carried away with these. Once the IDE core is clean
enough to allow hot plugging of IDE interfaces those __init's are all going
to need changing anyway

(and yes you can get hot pluggable IDE setups already - the mobility stuff
 for example has a case with a PCI split bridge, 3 or 4 PCI slots and
 connects to the cardbus on a laptop)
