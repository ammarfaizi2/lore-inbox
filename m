Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSEGOEp>; Tue, 7 May 2002 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSEGOEn>; Tue, 7 May 2002 10:04:43 -0400
Received: from ns.suse.de ([213.95.15.193]:57608 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315459AbSEGOEj>;
	Tue, 7 May 2002 10:04:39 -0400
Date: Tue, 7 May 2002 16:04:35 +0200
From: Dave Jones <davej@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
Message-ID: <20020507160435.R22215@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <15575.56603.518181.850621@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:56:43PM +0200, Mikael Pettersson wrote:
 > hdparm -i requires root privs.

hdparm itself doesn't, but you must be able to read /dev/hd*
Some distros have this owned by group 'disk' for eg. 
Adding yourself as a member of this group should allow you to
use hdparm without becoming root.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
