Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262069AbREPUI3>; Wed, 16 May 2001 16:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbREPUIT>; Wed, 16 May 2001 16:08:19 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:22913 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S262069AbREPUIN>;
	Wed, 16 May 2001 16:08:13 -0400
Date: Wed, 16 May 2001 22:05:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA/PDC/Athlon
Message-ID: <20010516220512.A1400@suse.cz>
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi>; from jlaako@pp.htv.fi on Wed, May 16, 2001 at 08:25:56PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 08:25:56PM +0300, Jussi Laako wrote:

> I tested 2.4.4-ac9 today on A7V133 machine. It booted up, but can't stand
> any load. It will deadlock (without oops) when the network/disk system faces
> any load.
> 
> There is also some new bug in VIA IDE driver. It misdetects cable as 80-w
> when it's only 40-w and causes some CRC errors and speed dropping. Some
> older kernels correctly detected the cable as 40-w and used UDMA33, this one
> tries to use UDMA100 and fails (of course). Is there any way to force cable
> detection to 40-w?

There were no changes lately in the VIA driver. Can you spot where the
problems begun?

-- 
Vojtech Pavlik
SuSE Labs
