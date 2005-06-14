Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFNU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFNU5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFNU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:57:09 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:11722 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261333AbVFNU5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:57:05 -0400
Date: Tue, 14 Jun 2005 22:56:54 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Andi Kleen <ak@muc.de>
Cc: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050614205654.GB7082@ojjektum.uhulinux.hu>
References: <20050610112515.691dcb6e.akpm@osdl.org> <20050611082642.GB17639@ojjektum.uhulinux.hu> <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <m14qc0c1xl.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qc0c1xl.fsf@muc.de>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 06:56:22PM +0200, Andi Kleen wrote:
> Steve Lord <lord@xfs.org> writes:
> >
> > So is this some P4 specific optimization which is not working as
> > intended?
> 
> The only pentium specific optimizations that are enabled by MPENTIUM4
> is to tell the compiler to compile for pentium4 and a few settings
> in arch/i386/Kconfig.
> 
> You could enable/disable these individually and see if you can track
> it down with a binary search.
> 
> Most of this stuff should be fairly harmless though and be only
> microoptimizations; I cannot see how they should cause user visible
> races.

I am 100% sure this is not a P4 optimization problem since I compiled my 
kernel for i586 and saw the same problem.


-- 
pozsy
