Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRG1PMW>; Sat, 28 Jul 2001 11:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266710AbRG1PML>; Sat, 28 Jul 2001 11:12:11 -0400
Received: from pixie.isr.ist.utl.pt ([193.136.138.97]:4100 "EHLO
	pixie.isr.ist.utl.pt") by vger.kernel.org with ESMTP
	id <S266688AbRG1PL5>; Sat, 28 Jul 2001 11:11:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.7 and VIA IDE
In-Reply-To: <lxvgkddrsh.fsf@pixie.isr.ist.utl.pt>
In-Reply-To: Rodrigo Ventura's message of "28 Jul 2001 15:58:22 +0100"
Content-Type: text/plain; charset=US-ASCII
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Date: 28 Jul 2001 16:12:02 +0100
Message-ID: <lxn15pdr5p.fsf@pixie.isr.ist.utl.pt>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


        This is sort of a continuation of my last msg. I tried a rpm
-Va on one xterm and a tar cf /dev/null / on another, and I got
another dma error:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

        I also have errors from the ethernet devices, e.g.

eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 1165(13) current 1165(13)
  Transmit list 00000000 vs. c1277540.
  0: @c1277200  length 800000aa status 000100aa
  1: @c1277240  length 800000aa status 000100aa
  2: @c1277280  length 800000aa status 000100aa
  3: @c12772c0  length 800000aa status 000100aa
  4: @c1277300  length 800000b2 status 000100b2
  5: @c1277340  length 8000009e status 0001009e
  6: @c1277380  length 800000aa status 000100aa
  7: @c12773c0  length 800000aa status 000100aa
  8: @c1277400  length 800000aa status 000100aa
  9: @c1277440  length 800000aa status 000100aa
  10: @c1277480  length 800000b2 status 000100b2
  11: @c12774c0  length 8000009e status 0001009e
  12: @c1277500  length 800000aa status 800100aa
  13: @c1277540  length 800000aa status 000100aa
  14: @c1277580  length 800000b2 status 000100b2
  15: @c12775c0  length 8000009e status 0001009e

        Cheers,

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585
