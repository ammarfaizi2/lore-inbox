Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSBKN2Y>; Mon, 11 Feb 2002 08:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289260AbSBKN2P>; Mon, 11 Feb 2002 08:28:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289240AbSBKN2D>; Mon, 11 Feb 2002 08:28:03 -0500
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager
To: pazke@orbita1.ru (Andrey Panin)
Date: Mon, 11 Feb 2002 13:41:11 +0000 (GMT)
Cc: James.Bottomley@HansenPartnership.com (James Bottomley),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020211090021.GA8012@pazke.ipt> from "Andrey Panin" at Feb 11, 2002 12:00:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aGhj-0006cu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can you please explain, what does this config.in fragment mean:
> 
> if [ "$CONFIG_VISWS" !=3D "y" ]; then
>    bool 'MCA support' CONFIG_MCA
>    if [ "$CONFIG_MCA" =3D "y" ]; then
> 	bool '   Support for the NCR Voyager Architecture' CONFIG_VOYAGER
> 	define_bool CONFIG_X86_TSC n
>    fi
> else
>    define_bool CONFIG_MCA n
> fi
> 
> How MCA and NCR Voyager support related to SGI Visual Workstations support
> (CONFIG_VISWS) ?

Exactly as it says. If its a VISWS machine it can't be a voyager
If it hasn't got MCA bus it can't be a voyager
If it is a VISWS it doesnt have MCA
 
