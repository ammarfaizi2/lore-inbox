Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291080AbSBLO1E>; Tue, 12 Feb 2002 09:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291081AbSBLO0z>; Tue, 12 Feb 2002 09:26:55 -0500
Received: from www.microgate.com ([216.30.46.105]:2316 "EHLO sol.microgate.com")
	by vger.kernel.org with ESMTP id <S291080AbSBLO0m>;
	Tue, 12 Feb 2002 09:26:42 -0500
Message-ID: <00e801c1b3d0$fb834c60$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Jens Axboe" <axboe@suse.de>, "David S. Miller" <davem@redhat.com>
Cc: <reddog83@chartermi.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <001701c1b312$24448ca0$0c00a8c0@diemos> <auto-000058467594@front1.chartermi.net> <20020212075636.T729@suse.de> <20020211.231152.130238010.davem@redhat.com> <20020212081431.A11779@suse.de>
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Date: Tue, 12 Feb 2002 08:24:29 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    The "real" fix for synclink is just something like this, afaics.
> >    
> > It is a PCI driver Jens, this change is not correct.
> 
> See my repeated follow-ups :-)

It is an ISA and PCI driver, but only the ISA adapter
uses DMA and requires DMA mapping.

Thanks for the patch Jens.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com

