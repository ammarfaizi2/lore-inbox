Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266492AbSISMCi>; Thu, 19 Sep 2002 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266646AbSISMCi>; Thu, 19 Sep 2002 08:02:38 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:29193 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266492AbSISMCh>; Thu, 19 Sep 2002 08:02:37 -0400
Date: Thu, 19 Sep 2002 13:07:40 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog stability
Message-ID: <20020919120740.GA42108@compsoc.man.ac.uk>
References: <1032360386.3d8891c2bc3d3@kolivas.net> <3D88ACB6.6374E014@digeo.com> <1032383868.3d88ed7c4cf2d@kolivas.net> <3D88F2D7.DD8519E6@digeo.com> <p05111a08b9aec118552d@[10.2.2.25]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05111a08b9aec118552d@[10.2.2.25]>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 04:55:13PM -0700, Jonathan Lundell wrote:

> >It was causing SMP boxes to crash mysteriously after
> >several hours or days. Quite a lot of them. Nobody
> >was able to explain why, so it was turned off.
> 
> This was in the context of 2.4.2-ac21. More of the thread,with no 
> conclusive result, can be found at 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.2/0906.html
> 
> Was there any resolution? Was the problem real, did it get fixed, and 

Some machines corrupt %ecx on the way back from an NMI. Perhaps that was
the factor all the people with problems saw.

regards
john

-- 
"Please crack down on the Chinaman's friends and Hitler's commander.  Mother is
the best bet and don't let Satan draw you too fast.  A boy has never wept ...
nor dashed a thousand kim. Did you hear me?"
	- Dutch Schultz
