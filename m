Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSC1LqJ>; Thu, 28 Mar 2002 06:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313139AbSC1Lp7>; Thu, 28 Mar 2002 06:45:59 -0500
Received: from ns.suse.de ([213.95.15.193]:43524 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313137AbSC1Lpu>;
	Thu, 28 Mar 2002 06:45:50 -0500
Date: Thu, 28 Mar 2002 12:45:48 +0100
From: Dave Jones <davej@suse.de>
To: Nathan Walp <faceprint@faceprint.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj2
Message-ID: <20020328124548.D23328@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan Walp <faceprint@faceprint.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328015928.A3607@suse.de> <20020328023543.GA28445@faceprint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 09:35:46PM -0500, Nathan Walp wrote:
 > Compile error in 2.5.7-dj2, 2.5.7-dj1 compiled fine, has been running 7
 > days now.  
 > 
 > make[4]: Entering directory `/usr/src/linux-2.5.7-dj2/drivers/scsi/aic7xxx'
 > gcc -D__KERNEL__ -I/usr/src/linux-2.5.7-dj2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
 > aic7xxx_osm.c: In function `ahc_linux_setup_tag_info':
 > aic7xxx_osm.c:1036: warning: implicit declaration of function `strtok'
 > aic7xxx_osm.c:1036: warning: assignment makes pointer from integer without a cast

Ok, thanks. I'll take a look at that later, even if it means reverting
to the -dj1 version of aic

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
