Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135364AbRDZMat>; Thu, 26 Apr 2001 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135367AbRDZMa3>; Thu, 26 Apr 2001 08:30:29 -0400
Received: from ns.suse.de ([213.95.15.193]:22545 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135364AbRDZMaU>;
	Thu, 26 Apr 2001 08:30:20 -0400
Date: Thu, 26 Apr 2001 14:30:12 +0200
From: Andi Kleen <ak@suse.de>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
Message-ID: <20010426143012.A18861@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0104252247480.1088-100000@freak.distro.conectiva> <Pine.LNX.4.30.0104260807001.6221-100000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104260807001.6221-100000@tiger>; from fxian@fxian.jukie.net on Thu, Apr 26, 2001 at 08:09:06AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 08:09:06AM -0400, Feng Xian wrote:
> It looks like the X consumes most of the memory (almost used up all the
> physical memory, more than 100M), it uses NVidia driver. I was also
> running pppoe but that took less memory.

You're probably using the NVidia provided driver module, right?
Try it without it and the "nv" driver.


-Andi 
