Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264139AbTCXJ4X>; Mon, 24 Mar 2003 04:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264145AbTCXJ4X>; Mon, 24 Mar 2003 04:56:23 -0500
Received: from nef.ens.fr ([129.199.96.32]:4877 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S264139AbTCXJ4W>;
	Mon, 24 Mar 2003 04:56:22 -0500
Date: Mon, 24 Mar 2003 11:07:20 +0100 (MET)
From: David Monniaux <David.Monniaux@ens.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Monniaux <David.Monniaux@ens.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C-Media 9739 codec - solution found
In-Reply-To: <1046438992.16598.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.03.10303241105580.7808-100000@basilic.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2003, Alan Cox wrote:

> > Who maintains the i810_audio / AC97-related things? I think the C-Media 
> > driver should be folded into the regular kernel (otherwise it won't get 
> > maintained).
> A lot of it duplicates existing functionality we have and in a different

I have spoken too fast too soon. The C-Media driver has some issues (some
weird sound glitches), sounding like it plays 48 kHz at while pretending
to use 44.1 kHz, using xmms.

I'll look into it ASAP.

David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'École Normale Supérieure,
Paris, France

