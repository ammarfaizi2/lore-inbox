Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTIFUHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTIFUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 16:07:04 -0400
Received: from smtp03.web.de ([217.72.192.158]:46626 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261814AbTIFUHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 16:07:02 -0400
From: "Mehmet Ceyran" <mceyran@web.de>
To: "'Michael Buesch'" <mbuesch@freenet.de>, <maxo@myrealbox.com>
Cc: "'linux kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: RE: bug/request: multi-processing for CD devices
Date: Sat, 6 Sep 2003 22:09:57 +0200
Message-ID: <001501c374b2$d9a6bdd0$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200309062056.19023.mbuesch@freenet.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Summary: request for multi-processing for CD devices (I 
>> think the word is 'multi-processing' - ie. so that you can
>> play an audio CD and browse the audio CD using a program
>> such as konqueror at the same time)
>> [...]
> As far as I know that should be impossible, because 
> audio-playing runs 100% on the cd-rom hardware itself. The OS 
> has nothing to do with it. So your request should go to the 
> device manufacturers and ask them if they could build 
> devices, that are "multithreaded". :)

Well that depends. The classic audio CD access is through hardware. The
drive spins down to 1x speed and dumps the data over its private line to
the soundcard's CDDA input channel. So in this case you're right.

The other way to do it is ripping the data through the drive's data bus,
like DAC tools do, and play the music on the fly. This way
'multi-processing' is possible.

So what you have to do is to find an audio player that plays CDDA with
the second method.

	Mehmet

