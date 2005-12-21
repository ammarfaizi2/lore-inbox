Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLUCDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLUCDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLUCDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:03:12 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:3513 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932251AbVLUCDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:03:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 2.6.15-rc6] alps: Add HP ze1115 support to alps driver
Date: Tue, 20 Dec 2005 21:03:08 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <43A8AF74.1080706@lwfinger.net>
In-Reply-To: <43A8AF74.1080706@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512202103.09151.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 20:27, Larry Finger wrote:
> This patch adds support for the touchpad found on HP ze1115 notebooks. 
> Patch file attached to preserve white space and line integrity.
> 
> PatchAuthor: Larry.Finger@lwfinger.net
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -40,6 +40,7 @@ static struct alps_model_info alps_model
>          { { 0x33, 0x02, 0x0a }, 0x88, 0xf8, ALPS_OLDPROTO }, 
>   /* UMAX-530T */
>          { { 0x53, 0x02, 0x0a }, 0xf8, 0xf8, 0 },
>          { { 0x53, 0x02, 0x14 }, 0xf8, 0xf8, 0 },
> +       { { 0x60, 0x03, 0xc8 }, 0xf8, 0xf8, 0 }, 
> /* HP ze1115 */
>          { { 0x63, 0x02, 0x0a }, 0xf8, 0xf8, 0 },
>          { { 0x63, 0x02, 0x14 }, 0xf8, 0xf8, 0 },
>          { { 0x63, 0x02, 0x28 }, 0xf8, 0xf8, ALPS_FW_BK_2 }, 
>   /* Fujitsu Siemens S6010 */
> 

Thank you Larry, I will add it to my tree.

-- 
Dmitry
