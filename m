Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269547AbRHCShF>; Fri, 3 Aug 2001 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbRHCSg7>; Fri, 3 Aug 2001 14:36:59 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20747 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269547AbRHCSgE>; Fri, 3 Aug 2001 14:36:04 -0400
Date: Fri, 3 Aug 2001 20:36:12 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803203612.I31468@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <0108030507330F.00440@starship> <Pine.GSO.4.21.0108022312211.1494-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108022312211.1494-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Alexander Viro wrote:

> On Fri, 3 Aug 2001, Daniel Phillips wrote:
> 
> > There is only one chain of directories from the fd's dentry up to the 
> > root, that's the one to sync.
> 
> You forgot ".. at any given moment". IOW, operation you propose is inherently
> racy. You want to do that - you do that in userland.

Applications usually protect their playgrounds - separate uid for
instance. If only the application has access to that area, and itself
does not trigger races, "at any given moment" is not a restriction.

-- 
Matthias Andree
