Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264568AbTCZD12>; Tue, 25 Mar 2003 22:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264579AbTCZD0a>; Tue, 25 Mar 2003 22:26:30 -0500
Received: from user-0can0ud.cable.mindspring.com ([24.171.131.205]:33670 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id <S264590AbTCZDYi>;
	Tue, 25 Mar 2003 22:24:38 -0500
Date: Tue, 25 Mar 2003 19:35:52 -0800
From: Eric Wong <eric@yhbt.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Logitech USB mice/trackball extensions
Message-ID: <20030326033552.GA13242@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326022938.GA5187@bl4st.yhbt.net>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, ignore this part, it's part of a separate patch :)

> +/* Module parameters */
> +MODULE_PARM(hid_poll_interval, "i");
> +MODULE_PARM_DESC(hid_poll_interval, "polling interval, millseconds (default=10)");
> +
> +#ifndef MODULE
> +static int __init hid_poll_interval_setup(char *str)
> +{
> +	get_option(&str,&hid_poll_interval);
> +	return 1;
> +}
> +
> +__setup("hid_poll_interval=", hid_poll_interval_setup);
> +
> +#endif
> +

-- 
Eric Wong
