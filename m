Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271746AbRHURG7>; Tue, 21 Aug 2001 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRHURGt>; Tue, 21 Aug 2001 13:06:49 -0400
Received: from adsl-63-193-119-253.dsl.snfc21.pacbell.net ([63.193.119.253]:27813
	"EHLO cowlabs.com") by vger.kernel.org with ESMTP
	id <S271746AbRHURGd>; Tue, 21 Aug 2001 13:06:33 -0400
From: <cfs+linux-kernel@cowlabs.com>
To: "'Marco Colombo'" <marco@esi.it>,
        "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>
Cc: "'David Wagner'" <daw@mozart.cs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random in 2.4.6
Date: Tue, 21 Aug 2001 10:06:24 -0700
Message-ID: <000801c12a63$9c9d54d0$0a90a5c7@cowlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0108211212570.20625-100000@Megathlon.ESI>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Marco Colombo
> Sent: Tuesday, 21 August 2001 03:46
> To: Alex Bligh - linux-kernel
> Cc: David Wagner; linux-kernel@vger.kernel.org
> Subject: Re: /dev/random in 2.4.6
> 
> A little question: I used to believe that crypto software 
> requires strong random source to generate key pairs, but this 
> requirement in not true for session keys.  You don't usually 
> generate a key pair on a remote system, of course, so that's 
> not a big issue. On low-entropy systems (headless servers) is 
> /dev/urandom strong enough to generate session keys? I guess 
> the little entropy collected by the system is enough to feed 
> the crypto secure PRNG for /dev/urandom, is it correct?

I dunno about you, but I want good random for session keys too!  You can
still capture network traffic and decrypt at your leisure if you can
determine what the "random" number was used in making the session key.

cfs

