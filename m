Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSJODHI>; Mon, 14 Oct 2002 23:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSJODHI>; Mon, 14 Oct 2002 23:07:08 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8711 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262331AbSJODHI>;
	Mon, 14 Oct 2002 23:07:08 -0400
Date: Mon, 14 Oct 2002 20:13:12 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@perex.cz>,
       torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, jdthood@yahoo.co.uk,
       boissiere@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
Message-ID: <20021015031312.GB10756@kroah.com>
References: <20021014135452.GB444@neo.rr.com> <Pine.LNX.4.33.0210142101000.7202-100000@pnote.perex-int.cz> <20021014214334.GA315@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014214334.GA315@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:43:34PM +0000, Adam Belay wrote:
>  #ifdef CONFIG_PROC_FS
> -	/*isapnp_proc_init();*/
> +	isapnp_proc_init();
>  #endif


Please bury the #ifdef in the .h file, it shouldn't be in the .c file.

thanks,

greg k-h
