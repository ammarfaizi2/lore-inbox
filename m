Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUIDRpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUIDRpz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUIDRpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:45:47 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:29358 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264991AbUIDRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:45:24 -0400
Message-ID: <4139FEB4.3080303@tungstengraphics.com>
Date: Sat, 04 Sep 2004 18:43:16 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org>	 <413997A7.9060406@tungstengraphics.com>	 <20040904112535.A13750@infradead.org>	 <4139995E.5030505@tungstengraphics.com>	 <20040904112930.GB2785@redhat.com>	 <4139A9F4.4040702@tungstengraphics.com>	 <20040904115442.GD2785@redhat.com>	 <4139B03A.6040706@tungstengraphics.com>	 <20040904122057.GC26419@redhat.com>	 <4139C8A3.6010603@tungstengraphics.com> <9e47339104090408362a356799@mail.gmail.com>
In-Reply-To: <9e47339104090408362a356799@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Sat, 04 Sep 2004 14:52:35 +0100, Keith Whitwell
> <keith@tungstengraphics.com> wrote:
> 
>>Currently we have to perform two merges and three releases to get a driver to
>>a users:
>>
>>        Merge DRM CVS --> LK
>>        Release stable kernel  --> Picked up by vendor
>>        Release stable Mesa 3D
>>        Merge Mesa 3D --> X.org
>>        Release stable X.org  --> Picked up by vendor
>>
> 
> 
> X on GL will make this process faster
> 
>          Merge DRM CVS --> LK
>          Release stable kernel  --> Picked up by vendor
>          Release stable Mesa 3D --> Picked up by vendor
>          Release stable X.org  --> Picked up by vendor
> 
> If DRM went into a kernel development model....
> 
>          Release stable kernel  --> Picked up by vendor
>          Release stable Mesa 3D --> Picked up by vendor
>          Release stable X.org  --> Picked up by vendor
> 
> This is the fastest model. Merges have been eliminated.

Yep.  Right now, I think it's really the Mesa/Xorg side that needs work and is 
the "critical path".  If we can convince/educate the distros to take 3D 
drivers from Mesa, that will be a good step in the right direction.

> 
> You may think that X on GL (gnuLonghorn) is a crazy idea. But
> comptetive pressures from the Mac and Longhhorn will force us into
> doing it so or later. I'd rather do it sooner.
> 

Not a crazy idea at all, plus I like the name.  But a fork could help relieve 
the tension between trying to maintain a stable DRM and the sorts of stuff 
that you need to do to move to the next level.  And I recognize that I get 
grumpy when it sounds like existing functionality is threatened by your desire 
to push off in a certain technical direction.  If gnuLonghorn/DRM makes a 
friendly/development fork off the existing DRM, things might go a little smoother.

Keith

