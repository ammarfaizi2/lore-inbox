Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSGCPfx>; Wed, 3 Jul 2002 11:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSGCPfx>; Wed, 3 Jul 2002 11:35:53 -0400
Received: from ns.suse.de ([213.95.15.193]:27142 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317034AbSGCPfv>;
	Wed, 3 Jul 2002 11:35:51 -0400
Date: Wed, 3 Jul 2002 17:38:22 +0200
From: Dave Jones <davej@suse.de>
To: Skip Ford <skip.ford@verizon.net>
Cc: James Simmons <jsimmons@transvirtual.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] New Console system BK
Message-ID: <20020703173822.C8934@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Skip Ford <skip.ford@verizon.net>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com> <200207020011.g620BTZ9000182@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207020011.g620BTZ9000182@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Mon, Jul 01, 2002 at 08:11:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 08:11:28PM -0400, Skip Ford wrote:
 > James Simmons wrote:
 > > 
 > > Since 2.5.1 I have placed into the kernel part of the new console system
 > > code into the DJ tree. So it has been well tested. I was hoping to have
 > > all the keyboard devices ported over to the input api and the fbdev
 > > drivers over to the new api. Unfortunely due to time restraints this will
 > > not be the case. So here goes the first installment of the new console
 > > system. Please test it yourselves and I will push it to Linus soon.
 > > 
 > >  http://www.transvirtual.com/~jsimmons/console.diff.gz
 > 
 > With your patch, I have to release the alt key between Fx keys to change
 > VTs.  Is that intentional?
 > 
 > Without the patch, I can hold down alt and hit F1, F2, F3, F4, then
 > release the alt key and I will have switched to each of the VTs.
 > With this patch, I have to press/release alt for each Fx key.

Strange, that's a reoccurance of a bug that happened many moons ago
circa 2.5.4-dj or so, which James then subsequently fixed. Seems he
dropped a bugfix or two..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
