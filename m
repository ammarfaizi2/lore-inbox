Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSEBNZF>; Thu, 2 May 2002 09:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314413AbSEBNZE>; Thu, 2 May 2002 09:25:04 -0400
Received: from ns.suse.de ([213.95.15.193]:5138 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314409AbSEBNZD>;
	Thu, 2 May 2002 09:25:03 -0400
Date: Thu, 2 May 2002 15:25:02 +0200
From: Dave Jones <davej@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
        cpufreq@www.linux.org.uk
Subject: Re: AMD PowerNow booboo in 2.4.19-pre7-ac3
Message-ID: <20020502152502.I16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Russell King <rmk@arm.linux.org.uk>, CaT <cat@zip.com.au>,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
In-Reply-To: <20020502085137.GP14678@zip.com.au> <20020502101723.B23709@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:17:23AM +0100, Russell King wrote:
 > >  MODULE_LICENSE ("GPL");
 > >  module_init(PowerNow_k6plus_init);
 > >  module_exit(PowerNow_k6plus_exit);
 > > -__initcall (PowerNOW_k6plus_init);
 > > +__initcall (PowerNow_k6plus_init);
 > > 
 > Hmm, that looks really odd - module_init() should be identical to __initcall
 > when built into the kernel.  Copied to the cpufreq list.

Odd, Alan must have merged an old version of the cvs tree, as the
initcalls were nuked a long time ago there iirc. They're certainly not
in my copy of the current tree

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
