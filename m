Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbRGRHH6>; Wed, 18 Jul 2001 03:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbRGRHHs>; Wed, 18 Jul 2001 03:07:48 -0400
Received: from mout03.kundenserver.de ([195.20.224.218]:64380 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267841AbRGRHHf> convert rfc822-to-8bit; Wed, 18 Jul 2001 03:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: "Dominick, David" <David.Dominick@delta.com>, linux-kernel@vger.kernel.org
Subject: Re: sound?!?!!?
Date: Wed, 18 Jul 2001 09:06:24 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <BDEE1F50C0C6D411BBB600204840D7B40124F181@satlrccdmrus25.delta-air.com>
In-Reply-To: <BDEE1F50C0C6D411BBB600204840D7B40124F181@satlrccdmrus25.delta-air.com>
MIME-Version: 1.0
Message-Id: <01071809062400.01130@Einstein.P-netz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when running sndconfig I get:
> /lib/modules/2.4.6/kernel/drivers/sound/sound.o: unresolved symbol
> request_module

Its only a guess, but have you included kmod in the Kernel?

cd /usr/src/linux
grep KMOD .config 
	should look like:

CONFIG_KMOD=y
