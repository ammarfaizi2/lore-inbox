Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270716AbRHPDWL>; Wed, 15 Aug 2001 23:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270719AbRHPDVv>; Wed, 15 Aug 2001 23:21:51 -0400
Received: from ns.caldera.de ([212.34.180.1]:52895 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270716AbRHPDVs>;
	Wed, 15 Aug 2001 23:21:48 -0400
Date: Thu, 16 Aug 2001 05:21:19 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: daddr_t is inconsistent and barely used
Message-ID: <20010816052119.A28800@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108160257.f7G2vYA18080@ns.caldera.de> <10589.997931660@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10589.997931660@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Aug 16, 2001 at 01:14:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 01:14:20PM +1000, Keith Owens wrote:
> On Thu, 16 Aug 2001 04:57:34 +0200, 
> Christoph Hellwig <hch@ns.caldera.de> wrote:
> >In article <9980.997929632@kao2.melbourne.sgi.com> you wrote:
> >> daddr_t is barely used in the kernel.  2.4.8.
> >>
> >> The use of daddr_t in freevxfs may give different in core and disk
> >> layouts on different machines.  Is that intended?.
> >
> >No, it may not.  Please double check.
> 
> That is why I said "may".  It seemed puzzling that freevxfs used
> vx_daddr_t for almost everything but daddr_t for a couple of fields.
> An inconsistency with no obvious reason.

vx_daddr_t is for disk structures, daddr_t for core.
