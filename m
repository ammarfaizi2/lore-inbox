Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318719AbSICHUX>; Tue, 3 Sep 2002 03:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSICHUX>; Tue, 3 Sep 2002 03:20:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50307 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318719AbSICHUW>;
	Tue, 3 Sep 2002 03:20:22 -0400
Date: Tue, 3 Sep 2002 12:50:17 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Enable kernel profiling with stepping of 1
Message-ID: <20020903125017.F21589@in.ibm.com>
References: <20020902134718.A21466@in.ibm.com> <Pine.LNX.4.33.0209022031240.912-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0209022031240.912-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Mon, Sep 02, 2002 at 08:38:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 08:38:22PM -0400, Mark Hahn wrote:
> > and the profiling buffer is half the size of kernel text; 2 insns hash on to
> 
> s/insns/bytes of code/

Yep.. I was speaking in terms of the smallest possible size for a insn.

> 
> > Profiling with step=1 will help us do insn level profiling with better
> > granularity
> 
> I guess this means you want to do insn- or line-wise profiling, rather 
> than the original point of this feature (function-wise).  

Exactly. 

Thanks,
Kiran
