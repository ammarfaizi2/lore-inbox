Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310126AbSCAVPa>; Fri, 1 Mar 2002 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310127AbSCAVPU>; Fri, 1 Mar 2002 16:15:20 -0500
Received: from ns.suse.de ([213.95.15.193]:55565 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310126AbSCAVPB>;
	Fri, 1 Mar 2002 16:15:01 -0500
Date: Fri, 1 Mar 2002 22:14:59 +0100
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] moving task_struct
Message-ID: <20020301221459.P7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203012040220.32042-100000@serv> <3C7FEAC9.DDA73021@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7FEAC9.DDA73021@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 03:55:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 03:55:37PM -0500, Jeff Garzik wrote:
 > > The patch below simply moves task_struct into its own header file.
 > > This makes thread_info and task_struct indepedent from sched.h and will 
 > > allows archs to decide themselves the dependencies between these
 > > structures.
 > 
 > nice...   In addition to your second patch, this first patch may be a
 > small step in paving the way for further unraveling of nasty include
 > dependencies.

 Indeedy doody. Roman has a nice set of Ruby scripts, which in 
 conjunction with acme's dependancy graph scripts make for some
 interesting reading.

 It's tedious work unraveling some of the dependancies, but it's
 paid off quite a bit already.  (For a real horror story, see
 the raid includes. They pull in an obscene amount of extra
 headers 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
