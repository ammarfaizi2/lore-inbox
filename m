Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRFJQqg>; Sun, 10 Jun 2001 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264033AbRFJQq1>; Sun, 10 Jun 2001 12:46:27 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:63496 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S264032AbRFJQqT>;
	Sun, 10 Jun 2001 12:46:19 -0400
Date: Sun, 10 Jun 2001 18:46:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Message-ID: <20010610184611.A16660@ontario.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010610175730.B15945@ontario.alcove-fr> <E1597bu-0006lf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <E1597bu-0006lf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 10, 2001 at 04:58:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 04:58:42PM +0100, Alan Cox wrote:

> > Yes. But, even if I know how to program the mchip to output to
> > the video bus, there is something missing to enable overlay
> > (either in the mchip or in the ati video driver).
> 
> It could be using the YUV digital inputs to the ATI chip. 

Most likely yes. 

> It seems however
> also quite likely to me that windows is doing the following
> 
> 1.	Issuing USB transfers which put the data into video ram overlay buffers
> 	(ie the DMA from the USB controller)

:s/USB/PCI/g

The rest seems good to me :-) I even think that the docs we have
are sufficient for this part (programming the mchip dma).

> 2.	Using the YUV overlay/expand hardware in the ATI card 
> 	(see www.gatos.org for X stuff for ATI for this)

:s/www.gatos.org/www.linuxvideo.org/gatos/

I took a quick look on their site but it seems that the
Rage Mobility P/M card which this laptop has isn't yet supported.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
