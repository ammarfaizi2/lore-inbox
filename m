Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHOS7t>; Thu, 15 Aug 2002 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSHOS7t>; Thu, 15 Aug 2002 14:59:49 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:15522
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S317194AbSHOS7s>; Thu, 15 Aug 2002 14:59:48 -0400
Date: Thu, 15 Aug 2002 12:03:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: henrique <henrique@cyclades.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020815190336.GN22974@opus.bloom.county>
References: <200208151514.51462.henrique@cyclades.com> <20020815182556.GV9642@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815182556.GV9642@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 12:25:56PM -0600, Andreas Dilger wrote:

> On Aug 15, 2002  15:14 +0000, henrique wrote:
> > Hello !!!
> > 
> > I am trying to use a program (ipsec newhostkey) that uses the random device 
> > provided by the linux-kernel. In a x86 machine the program works fine but 
> > when I tried to run the program in a PPC machine it doesn't work.
> > 
> > Looking carefully I have discovered that the problem is in the driver 
> > random.c. When the program tries to read any amount of data it locks and 
> > never returns. It happens because the variable  "random_state->entropy_count" 
> > is always zero, that is, any random number is generated at all !!!??.
> > 
> > Does anyone know anything about this problem ? Any sort of help is very 
> > welcomed.
> 
> Maybe the PPC keyboard/mouse drivers do not add randomness?

Well, how is this set for the i386 ones?  I grepped around and I didn't
really see anything, so I'm sort-of confused.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
