Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWBGDh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWBGDh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWBGDh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:37:58 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:46988 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964957AbWBGDh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:37:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Date: Mon, 6 Feb 2006 22:37:55 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191916.GB17460@srcf.ucam.org> <20060207003748.GA22510@srcf.ucam.org>
In-Reply-To: <20060207003748.GA22510@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602062237.55653.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 19:37, Matthew Garrett wrote:
> +static void __exit dellbl_exit(void)
> +{
> +       backlight_device_unregister(dell_backlight_device);
> +}
> +
> +module_init(hpbl_init);
> +module_exit(hpbl_exit);

This is not gonna work - dellbl_* vs hpbl_*
-- 
Dmitry
