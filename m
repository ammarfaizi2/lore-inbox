Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRG3OTU>; Mon, 30 Jul 2001 10:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268724AbRG3OTK>; Mon, 30 Jul 2001 10:19:10 -0400
Received: from pixie.isr.ist.utl.pt ([193.136.138.97]:16390 "EHLO
	pixie.isr.ist.utl.pt") by vger.kernel.org with ESMTP
	id <S268614AbRG3OTD>; Mon, 30 Jul 2001 10:19:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.7 and VIA IDE
In-Reply-To: <E15QWqv-0007qf-00@the-village.bc.nu>
Content-Type: text/plain; charset=US-ASCII
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Date: 30 Jul 2001 15:18:56 +0100
In-Reply-To: Alan Cox's message of "Sat, 28 Jul 2001 17:22:09 +0100 (BST)"
Message-ID: <lxn15mts8f.fsf@pixie.isr.ist.utl.pt>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> This is sort of a continuation of my last msg. I tried a rpm
    >> -Va on one xterm and a tar cf /dev/null / on another, and I got
    >> another dma error:
    >> 
    >> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
    >> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

    Alan> BadCRC is normally a cable error, but I'm suspicious that
    Alan> its also one of the things caused by PCI bus problems on the
    Alan> VIA stuff

        Bull's eye! I just replaced the cable, which in fact was sort
of long, by a shorter one, and it seems OK now.

        Cheers,

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585
