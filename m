Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310154AbSCPPt1>; Sat, 16 Mar 2002 10:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310413AbSCPPtH>; Sat, 16 Mar 2002 10:49:07 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:64271 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S310408AbSCPPs4>;
	Sat, 16 Mar 2002 10:48:56 -0500
Date: Sat, 16 Mar 2002 15:48:50 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules
Message-ID: <20020316154848.GA82190@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0203161126130.1090-100000@einstein.homenet> <16358.1016282075@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16358.1016282075@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:34:35PM +1100, Keith Owens wrote:

> I can see no good reason why the syscall table has been exported.

please don't change this. Just because it breaks on architectures X
and Y doesn't mean it's useless.

System call snooping is an ugly thing but being able to do it without
patching the kernel is incredibly useful. We're not unaware that
it is arch-specific.

regards
john

-- 
I am a complete moron for forgetting about endianness. May I be
forever marked as such.
