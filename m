Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313159AbSDDMRD>; Thu, 4 Apr 2002 07:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSDDMQy>; Thu, 4 Apr 2002 07:16:54 -0500
Received: from ns.suse.de ([213.95.15.193]:10001 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313159AbSDDMQs>;
	Thu, 4 Apr 2002 07:16:48 -0500
Date: Thu, 4 Apr 2002 14:16:47 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj3
Message-ID: <20020404141647.T20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404054923.A28437@suse.de> <Pine.NEB.4.44.0204040946500.7845-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 09:50:32AM +0200, Adrian Bunk wrote:
 > pdc4030.c: In function `promise_multwrite':
 > pdc4030.c:447: warning: passing arg 2 of `bio_kmap_irq' makes pointer from
 > integer without a cast
 > pdc4030.c: In function `promise_rw_disk':
 > pdc4030.c:664: structure has no member named `channel'

Ok, I'm confused.
This is a compile failure from 2.5.8-pre1.
The line numbers don't even match up to whats in -dj3

Forgot to apply -dj3 patch ?

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
