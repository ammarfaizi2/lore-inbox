Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280776AbRKOIEz>; Thu, 15 Nov 2001 03:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280773AbRKOIEq>; Thu, 15 Nov 2001 03:04:46 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:22788 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280774AbRKOIEg>;
	Thu, 15 Nov 2001 03:04:36 -0500
Message-ID: <3BF37712.4050801@epfl.ch>
Date: Thu, 15 Nov 2001 09:04:34 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: mjustice@austin.rr.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with i820 AGP patch
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr> <20011115062709.GA2022@sapience.com> <01111501143205.00746@bozo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Justice wrote:


 On the other hand, the performance is pretty much 
> the same as "agp_try_unsupported=1" :-). How does your /proc/interrupts look?
> 
> 
This is not really surprising. If you look through 'agpgart_be.c', you can see that 

only the initialization is different. All the rest goes through the same generic routines.

There are already too many of these initializations in the file... but I 
think that R. Love is working on a cleaner version.

Regards

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

