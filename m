Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTFNVzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFNVzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:55:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13038 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261169AbTFNVzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:55:21 -0400
Date: Sun, 15 Jun 2003 00:09:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davej@codemonkey.org.uk
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: remove unused var from serio struct
Message-ID: <20030615000907.A26994@ucw.cz>
References: <200303241642.h2OGgB35008333@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200303241642.h2OGgB35008333@deviant.impure.org.uk>; from davej@codemonkey.org.uk on Mon, Mar 24, 2003 at 04:41:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:41:58PM +0000, davej@codemonkey.org.uk wrote:

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/serio.h linux-2.5/include/linux/serio.h
> --- bk-linus/include/linux/serio.h	2003-03-08 09:57:59.000000000 +0000
> +++ linux-2.5/include/linux/serio.h	2003-02-13 22:21:33.000000000 +0000
> @@ -25,7 +25,6 @@ struct serio {
>  	void *driver;
>  	char *name;
>  	char *phys;
> -	int number;
>  
>  	unsigned short idbus;
>  	unsigned short idvendor;

Applied, thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
