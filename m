Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSE2MqF>; Wed, 29 May 2002 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSE2MqF>; Wed, 29 May 2002 08:46:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26613 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315207AbSE2MqE>; Wed, 29 May 2002 08:46:04 -0400
Subject: Re: odd timer bug, similar to VIA 686a symptoms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neale Banks <neale@lowendale.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10205292316380.3388-100000@marina.lowendale.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 14:48:51 +0100
Message-Id: <1022680131.4123.210.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 14:18, Neale Banks wrote:
> Does it help in that it's got a CMD640?  If not, what am I looking for?

Thats the IDE controller. Look at lspci and the bridges and see what
they are. Those are generally the core chipset of the PC

