Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315860AbSEMHBr>; Mon, 13 May 2002 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315861AbSEMHBq>; Mon, 13 May 2002 03:01:46 -0400
Received: from imladris.infradead.org ([194.205.184.45]:39437 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315860AbSEMHBq>; Mon, 13 May 2002 03:01:46 -0400
Date: Mon, 13 May 2002 08:01:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
Message-ID: <20020513080133.A28324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, Keith Owens <kaos@ocs.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020512203615.A12612@averell> <25899.1021244460@ocs3.intra.ocs.com.au> <20020513014051.A1737@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:40:51AM +0200, Andi Kleen wrote:
> --- linux-vanilla/drivers/media/radio/Config.in	Sun Apr 14 21:18:54 2002
> +++ linux/drivers/media/radio/Config.in	Thu May  9 20:07:45 2002
> @@ -4,6 +4,7 @@
>  mainmenu_option next_comment
>  comment 'Radio Adapters'
>  
> +if [ "$CONFIG_ISA" = "y" ]; then
>  dep_tristate '  ADS Cadet AM/FM Tuner' CONFIG_RADIO_CADET $CONFIG_VIDEO_DEV
>  dep_tristate '  AIMSlab RadioTrack (aka RadioReveal) support' CONFIG_RADIO_RTRACK $CONFIG_VIDEO_DEV
>  if [ "$CONFIG_RADIO_RTRACK" = "y" ]; then
> @@ -21,9 +22,11 @@ dep_tristate '  GemTek Radio Card suppor
>  if [ "$CONFIG_RADIO_GEMTEK" = "y" ]; then
>     hex '    GemTek i/o port (0x20c, 0x30c, 0x24c or 0x34c)' CONFIG_RADIO_GEMTEK_PORT 34c
>  fi
> +fi

Could you please update the indentation?
