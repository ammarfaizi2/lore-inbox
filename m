Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTBQNfj>; Mon, 17 Feb 2003 08:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBQNfj>; Mon, 17 Feb 2003 08:35:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3208
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267059AbTBQNfi>; Mon, 17 Feb 2003 08:35:38 -0500
Subject: Re: IO-APIC not working on 645DX chipset??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Allan Klinbail <allank@labyrinth.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045484341.16628.55.camel@littlewolf2.littlewolf>
References: <1045484341.16628.55.camel@littlewolf2.littlewolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045493209.19397.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Feb 2003 14:46:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 12:18, Allan Klinbail wrote:
> Hi 
> 
> I don't see that anyone else has experienced this. It may be just my
> particular Motherboard Gigabyte GA-8ST667. (SiS 645DX chipset) 
> 
> If I compile a kernel with 
> IO-APIC support on uniprocessors , enabled.then, the system succesfully
> loads up modules for USB, ethernet card,scsi card, soundcards e.t.c..
> but they don't actually work... 

2.4.x doesn't have work arounds for the SIS io-apic problems. SiS have 
told us what they are so there is a sort of workaround in 2.5. For 2.4.x
I'm still waiting for a list of afflicted devices from them so I can do
a safe minimal workaround to feed to Marcelo.

Alan

