Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWBJFxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWBJFxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWBJFxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:53:41 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:56812 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751146AbWBJFxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:53:40 -0500
Message-ID: <43EC26E1.5020804@gmail.com>
Date: Fri, 10 Feb 2006 09:38:41 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/media/dvb/bt8xx/: make 2 structs static
References: <20060210004643.GL3524@stusta.de>
In-Reply-To: <20060210004643.GL3524@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes two needlessly global structs static.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/media/dvb/bt8xx/bt878.c |    2 +-
>  drivers/media/dvb/bt8xx/dst.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c.old	2006-02-09 22:09:00.000000000 +0100
> +++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c	2006-02-09 22:09:07.000000000 +0100
> @@ -382,7 +382,7 @@
>  EXPORT_SYMBOL(bt878_device_control);
>  
>  
> -struct cards card_list[] __devinitdata = {
> +static struct cards card_list[] __devinitdata = {
>  
>  	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,			"Nebula Electronics DigiTV" },
>  	{ 0x07611461, BTTV_BOARD_AVDVBT_761,			"AverMedia AverTV DVB-T 761" },
> --- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c.old	2006-02-09 22:09:21.000000000 +0100
> +++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c	2006-02-09 22:09:29.000000000 +0100
> @@ -602,7 +602,7 @@
>  
>  */
>  
> -struct dst_types dst_tlist[] = {
> +static struct dst_types dst_tlist[] = {
>  	{
>  		.device_id = "200103A",
>  		.offset = 0,
>
> -
>   


Ack'd-by: Manu Abraham <manu@linuxtv.org>

