Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFPSbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFPSbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFPSbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:31:05 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:6661 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S264411AbUFPSa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:30:56 -0400
Date: Wed, 16 Jun 2004 18:30:51 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Corey Minyard <minyard@acm.org>
cc: Alex Williamson <alex.williamson@hp.com>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: IPMI hangup in 2.6.6-rc3
In-Reply-To: <40D05779.9080203@acm.org>
Message-Id: <Pine.LNX.4.58.0406161822280.13439@praktifix.dwd.de>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de> 
 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
 <1086887543.4182.46.camel@tdi> <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
 <40D056E2.4010605@acm.org> <40D05779.9080203@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Corey Minyard wrote:

> I missed a part of the patch, here is a new one with the include file changes.
> 
> -Corey
> 
> Corey Minyard wrote:
> 
> > Unfortuantely, that fix has some problems, but it was on the right track.  I
> > have a new patch attached; can you try it out?  Also, the kernel interface
> > has not changed.  It should be exactly the same as before.
> > 
> > -Corey
> 
Yes, with this patch it no longer hangs. But ipmitool still crashes

    root@apollo:~# ipmitool -I open sdr list
    Segmentation fault

I will try to contact the author of ipmitool.

Holger
