Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312290AbSDDMhq>; Thu, 4 Apr 2002 07:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSDDMhh>; Thu, 4 Apr 2002 07:37:37 -0500
Received: from ns.suse.de ([213.95.15.193]:14596 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312290AbSDDMhX>;
	Thu, 4 Apr 2002 07:37:23 -0500
Date: Thu, 4 Apr 2002 14:37:22 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>,
        "martin @ dalecki . de Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj3
Message-ID: <20020404143722.V20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	"martin @ dalecki . de Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404054923.A28437@suse.de> <Pine.NEB.4.44.0204040946500.7845-100000@mimas.fachschaften.tu-muenchen.de> <20020404141647.T20040@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:16:47PM +0200, Dave Jones wrote:
 > On Thu, Apr 04, 2002 at 09:50:32AM +0200, Adrian Bunk wrote:
 >  > pdc4030.c: In function `promise_multwrite':
 >  > pdc4030.c:447: warning: passing arg 2 of `bio_kmap_irq' makes pointer from
 >  > integer without a cast
 >  > pdc4030.c: In function `promise_rw_disk':
 >  > pdc4030.c:664: structure has no member named `channel'
 > 
 > Ok, I'm confused.
 > This is a compile failure from 2.5.8-pre1.
 > The line numbers don't even match up to whats in -dj3


My bad. _I_ was looking at a wrong tree.
I'll fix these bits up later and push them Martins way, as there
are a few other small IDE bits that have been lingering in my
tree since 2.5.2 days.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
