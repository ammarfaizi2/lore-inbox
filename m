Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVLVTKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVLVTKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 14:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVLVTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 14:10:09 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:64458
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1030227AbVLVTKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 14:10:07 -0500
Date: Thu, 22 Dec 2005 14:09:28 -0500
From: Sonny Rao <sonny@burdell.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, anton@samba.org, shai@scalex86.org,
       sonnyrao@us.ibm.com, alokk@calsoftinc.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051222190928.GA24385@kevlar.burdell.org>
References: <20051219051659.GA6299@kevlar.burdell.org> <20051222092743.GE3915@localhost.localdomain> <20051222173700.GA5723@localhost.localdomain> <20051222175311.GA22393@kevlar.burdell.org> <20051222183750.GA3704@localhost.localdomain> <20051222183951.GA23469@kevlar.burdell.org> <Pine.LNX.4.62.0512221053100.8260@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512221053100.8260@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 10:54:08AM -0800, Christoph Lameter wrote:
> On Thu, 22 Dec 2005, Sonny Rao wrote:
> 
> > Yes, rc6 + the patch you provided.
> 
> We may be going down the wrong path here. Has someone else than Sonny 
> reproduced the problem?

Hi, I've also just reproduced the problem on another machine which does
have multiple cpus/node rather than just one cpu/node. The crash
occurs at the same place when I attempt to offline the last cpu in a
node.

But, I agree that somemone else should repro this.  I only have ppc64
machines available to me right now.

Sonny
