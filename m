Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280692AbRKFXlu>; Tue, 6 Nov 2001 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280694AbRKFXli>; Tue, 6 Nov 2001 18:41:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280692AbRKFXl2>; Tue, 6 Nov 2001 18:41:28 -0500
Subject: Re: PCI like interface for ISAPnP
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Tue, 6 Nov 2001 23:48:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0111070025470.9978-100000@vaio> from "Kai Germaschewski" at Nov 07, 2001 12:40:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161FxM-0002Gb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the question is: Should I provide a generic isapnp_{,un}register_driver 
> framework (it's pretty simple anyway), or keep things private to my 
> driver?

Please do - I added one for pnpbios and for 2.5 we need a generic layer
for all cases.
