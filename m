Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUGKEvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUGKEvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGKEvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:51:09 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:3474 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266496AbUGKEvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:51:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adam Kropelin <akropel1@rochester.rr.com>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Date: Sat, 10 Jul 2004 23:51:05 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tim.bird@am.sony.com, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
References: <40EEF10F.1030404@am.sony.com> <20040710182527.47534358.akpm@osdl.org> <20040710234459.A26981@mail.kroptech.com>
In-Reply-To: <20040710234459.A26981@mail.kroptech.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102351.05059.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 10:44 pm, Adam Kropelin wrote:
> +		/* Round the value and print it */	
> +		printk("%lu.%02lu BogoMIPS\n",
> +			loops_per_jiffy/(500000/HZ),
> +			(loops_per_jiffy/(5000/HZ)) % 100);
> +		printk("Set 'Preset loops_per_jiffy'=%lu for preset lpj.\n",
> +			loops_per_jiffy);

Do we need to encourage ordinary users to turn this option on? 99% of
non-embedded market is much safer with that option off...

-- 
Dmitry
