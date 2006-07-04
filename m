Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWGDIW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWGDIW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWGDIW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:22:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50882 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751238AbWGDIW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:22:57 -0400
Subject: Re: Driver for Microsoft USB Fingerprint Reader
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607031549w734c82f4h28bb887709c32f44@mail.gmail.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <1151966154.16528.42.camel@localhost.localdomain>
	 <e1e1d5f40607031549w734c82f4h28bb887709c32f44@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 09:39:30 +0100
Message-Id: <1152002370.28597.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 18:49 -0400, ysgrifennodd Daniel Bonekeeper:
> At least they have something in common: all of them deliver an image
> as output. Maybe that could be centralized somehow... for example, a

Not even that.

For those that do we have the video4linux API ("its just a bad webcam")
for the smartcard type devices the interfaces are generally unrelated.

> How does encryption-based readers works ? I suppose that a software
> driver or library in userspace should be responsible for decrypting
> the image and processing it, right ? 

Usually you pick a combination of recognition algorithm and algorithm
that makes the per data unique per chip such that the recognition
algorithm can compare two sets of scrambled data.


