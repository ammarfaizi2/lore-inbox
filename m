Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSDPXUZ>; Tue, 16 Apr 2002 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313948AbSDPXUY>; Tue, 16 Apr 2002 19:20:24 -0400
Received: from ns.suse.de ([213.95.15.193]:55045 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313947AbSDPXUY>;
	Tue, 16 Apr 2002 19:20:24 -0400
Date: Wed, 17 Apr 2002 01:20:21 +0200
From: Dave Jones <davej@suse.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SOFT_WATCHDOG missing from 2.5.8-dj1
Message-ID: <20020417012020.E32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	A Guy Called Tyketto <tyketto@wizard.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020416230737.GA6142@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 04:07:37PM -0700, A Guy Called Tyketto wrote:
 > 
 >         Once again, subject sez it all. CONFIG_SOFT_WATCHDOG is mentioned in 
 > drivers/char/Config.help, but is not a configurable option in any part of make 
 > {old,x,menu}config. Therefore isn't compiled or even touched:
 > 
 > bradl@bellicha:/usr/src/linux/drivers/char> grep CONFIG_SOFT_WATCHDOG Config.in
 > bradl@bellicha:/usr/src/linux/drivers/char> 

I'll fix this up in -dj2 by adding the missing
tristate '  Software Watchdog' CONFIG_SOFT_WATCHDOG
to Config.in

Thanks for pointing it out.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
