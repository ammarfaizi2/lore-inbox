Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSEALd2>; Wed, 1 May 2002 07:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSEALd1>; Wed, 1 May 2002 07:33:27 -0400
Received: from ns.suse.de ([213.95.15.193]:14602 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310654AbSEALd0>;
	Wed, 1 May 2002 07:33:26 -0400
Date: Wed, 1 May 2002 13:33:25 +0200
From: Dave Jones <davej@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] TRIVIAL 2.5.12 WP security warning
Message-ID: <20020501133325.G29327@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <E172oSp-0007ot-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 05:23:47PM +1000, Rusty Russell wrote:
 > Pavel Machek <pavel@ucw.cz>: Warn users about machines with non-working WP bit:
 >   Hi!
 >   
 >   This might be good idea, as those machines are not safe for multiuser
 >   systems.
 >   
 > -		printk("No.\n");
 > +		printk("No (that's security hole).\n");
 >  #ifdef CONFIG_X86_WP_WORKS_OK

Maybe be a little more explicit in the wording ?

"No. This system is insecure in a multiuser environment.\n" perhaps ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
