Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTH0HNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbTH0HNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:13:19 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:22959 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263199AbTH0HNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:13:14 -0400
Date: Wed, 27 Aug 2003 10:12:59 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030827071259.GV83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org, tejun@aratech.co.kr
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827090351.51a0fc31.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827090351.51a0fc31.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:03:51AM +0200, you [Stephan von Krawczynski] wrote:
> > On Wed, Jul 30, 2003 at 09:10:03PM +0300, you [Ville Herva] wrote:
> > [...]
> >   - HW: Intel 815EEA2LU mobo, i815, Celeron Tualatin 1.3GHz. Adaptec 2940,
> >     9GB Seagate, HP C1537A tapedrive (not used), IBM-DTLA-305030 ide disk.
> >   - The aic7xxx driver has been acting up in past: crashes on boot and 
> >     sometimes at runtime too. I don't know if this is at all related to the
> >     lock ups.
> >   - Kernels tried: 2.4.22-pre8/gcc-2.96-85, 2.4.21-jam1/2.4.21-jam1, 
> >     2.4.21-jam1/gcc-3.2.1-2, 2.4.20pre7 -- all hang.

Forgot to mention: all fs's are ext2.
 
> > Perhaps this is related to the "Race condition in 2.4 tasklet handling
> > (cli() broken?)" problem TeJun Huh and Stephan von Krawczynski have been
> > discussing?
> 
> This is no SMP box, is it? If it is no SMP is it probably unrelated.

Yes, no SMP.


-- v --

v@iki.fi
