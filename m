Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319170AbSIDMpK>; Wed, 4 Sep 2002 08:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319171AbSIDMpJ>; Wed, 4 Sep 2002 08:45:09 -0400
Received: from stine.vestdata.no ([195.204.68.10]:23971 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S319170AbSIDMpI>; Wed, 4 Sep 2002 08:45:08 -0400
Date: Wed, 4 Sep 2002 14:49:09 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Message-ID: <20020904144909.Z6228@vestdata.no>
References: <Pine.GSO.4.21.0209040258480.7852-100000@weyl.math.psu.edu> <200209040902.g84927L29020@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209040902.g84927L29020@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Sep 04, 2002 at 11:02:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 11:02:07AM +0200, Peter T. Breuer wrote:
> > There is more to coherency and preserving fs structure than "don't cache
> 
> Sure. So what?  What's wrong with a O_DIRDIRECT flag that makes all
> opens retrace the path from the root fs _on disk_ instead of from the 
> directory cache? 

Did you read Antons post about this?

> I suggest that changing FS structure is an operation that is so
> relatively rare  in the projected environment (in which gigabytes of
> /data/ are streaming through every second) that you can make them as
> expensive as you like and nobody will notice. 

Why do you want a filesystem if you're not going to use any filesystem
operations? If all you want to do is to split your shared device into
multipe (static) logical units use a logical volume manager. 

If you _do_ need a filesystem, use something like gfs. Have you looked
at it at all?



-- 
Ragnar Kjørstad
Big Storage
