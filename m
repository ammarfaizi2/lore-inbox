Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSBMSTe>; Wed, 13 Feb 2002 13:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSBMST2>; Wed, 13 Feb 2002 13:19:28 -0500
Received: from mail.sonytel.be ([193.74.243.200]:31961 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S288173AbSBMSSu>;
	Wed, 13 Feb 2002 13:18:50 -0500
Date: Wed, 13 Feb 2002 19:14:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>, Simon Richter <Simon.Richter@fs.tum.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10202131000090.29350-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0202131912390.17760-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, James Simmons wrote:
> Another try at the amiga input keyboard driver. Here you go. Please apply
> 
> diff -urN -X /home/jsimmons/dontdiff linux-2.5.4-dj1/drivers/input/keyboard/Config.help linux/drivers/input/keyboard/Config.help
> --- linux-2.5.4-dj1/drivers/input/keyboard/Config.help	Tue Feb 12 10:48:06 2002
> +++ linux/drivers/input/keyboard/Config.help	Wed Feb 13 10:30:17 2002
> @@ -55,3 +55,12 @@
>    The module will be called maple_keyb.o. If you want to compile it as a
>    module, say M here and read <file:Documentation/modules.txt>.
>  
> +CONFIG_KEYBOARD_AMIGA
> +  Say Y here if you are running Linux on a m68k amiga and have a keyboard
                                              ^^^^^^^^^^
> +  attached.	

I see no reason (assumed it works on the m68k Amigas) why it wouldn't work on
PPC Amigas (that's APUS, i.e. a m68k Amiga with a PPC expansion board).

And please capitalize the word `Amiga' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

