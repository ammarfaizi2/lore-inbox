Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317372AbSFHA5B>; Fri, 7 Jun 2002 20:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSFHA5A>; Fri, 7 Jun 2002 20:57:00 -0400
Received: from ns.suse.de ([213.95.15.193]:56848 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317372AbSFHA5A>;
	Fri, 7 Jun 2002 20:57:00 -0400
Date: Sat, 8 Jun 2002 02:57:00 +0200
From: Dave Jones <davej@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        diego@biurrun.de, jerry.c.t@web.de, mike@pieper-family.de,
        hollis@austin.ibm.com
Subject: Re: Updates to matroxfb: do you want DFP or TVOut on G450/G550?
Message-ID: <20020608025700.B13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, diego@biurrun.de, jerry.c.t@web.de,
	mike@pieper-family.de, hollis@austin.ibm.com
In-Reply-To: <20020608004539.GB5090@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 02:45:39AM +0200, Petr Vandrovec wrote:
 > (4) You can read PINS through /proc.
 > (H) Change /proc code to use driverfs instead. Linus refused
 >     /proc based code already.

One of the first things I ever wrote for Linux was a PINS decoder.
It read from /dev/mem to get the PINS structure. Any reason
why this isn't good enough, and we need the kernel exporting PINS ?


        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
