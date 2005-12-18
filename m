Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVLRD7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVLRD7v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVLRD7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:59:51 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:5308 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965054AbVLRD7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:59:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.15-git] alps: Add Fujitsu Siemens S6010 support to alps driver.
Date: Sat, 17 Dec 2005 22:59:47 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <20051218023835.GA15232@swissdisk.com>
In-Reply-To: <20051218023835.GA15232@swissdisk.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512172259.48015.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 December 2005 21:38, Ben Collins wrote:
> PatchAuthor: andrew.waldrom@siemens.com
> Reference: http://bugzilla.ubuntu.com/13404
>     
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index a80d6b9..3cffe1d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -42,7 +42,7 @@ static struct alps_model_info alps_model
>  	{ { 0x53, 0x02, 0x14 },	0xf8, 0xf8, 0 },
>  	{ { 0x63, 0x02, 0x0a },	0xf8, 0xf8, 0 },
>  	{ { 0x63, 0x02, 0x14 },	0xf8, 0xf8, 0 },
> -	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, 0 },
> +	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */
>  	{ { 0x63, 0x02, 0x3c },	0x8f, 0x8f, ALPS_WHEEL },		/* Toshiba Satellite S2400-103 */
>  	{ { 0x63, 0x02, 0x50 },	0xef, 0xef, ALPS_FW_BK_1 },		/* NEC Versa L320 */
>  	{ { 0x63, 0x02, 0x64 },	0xf8, 0xf8, 0 },

This one is already in Linus's tree.

-- 
Dmitry
