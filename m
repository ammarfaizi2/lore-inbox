Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRITCbr>; Wed, 19 Sep 2001 22:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274177AbRITCbi>; Wed, 19 Sep 2001 22:31:38 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.133]:23939 "EHLO
	continuum.cm.nu") by vger.kernel.org with ESMTP id <S271691AbRITCbV> convert rfc822-to-8bit;
	Wed, 19 Sep 2001 22:31:21 -0400
Date: Wed, 19 Sep 2001 19:31:28 -0700
From: Shane Wegner <shane@cm.nu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Martin MOKREJ? <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010919193128.A8650@cm.nu>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu> <20010920004543.Z720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20010920004543.Z720@athlon.random>
User-Agent: Mutt/1.3.20i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 12:45:43AM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 19, 2001 at 03:34:41PM -0700, Shane Wegner wrote:
> > 
> > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > c012e052
> > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > c012e052
> > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > c012e052
> 
> yes, please try this fix and let me know if it helps:

After some stress testing, the fix does appear to fix the
error.

Shane


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
