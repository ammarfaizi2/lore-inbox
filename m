Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWHKTha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHKTha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWHKTh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:37:29 -0400
Received: from mail.suse.de ([195.135.220.2]:2796 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932291AbWHKTh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:37:29 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH for review] [69/145] x86_64: Disable DAC on VIA PCI bridges
Date: Fri, 11 Aug 2006 21:36:12 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810935.775038000@suse.de> <200608110851.53038.ak@suse.de> <20060811191311.GI4745@rhun.haifa.ibm.com>
In-Reply-To: <20060811191311.GI4745@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608112136.12378.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 21:13, Muli Ben-Yehuda wrote:
> On Fri, Aug 11, 2006 at 08:51:53AM +0200, Andi Kleen wrote:
> 
> > I've haven't decided yet. I put it out for review for now at least.
> > 
> > I got various reports of the VIA bridges having trouble with DAC over the
> > years, but usually when I asked for confirmation the reporters disappeared.
> > I finally did the patch now because with cheap 2GB DIMMs VIA systems
> > with 4GB (which gives some memory over 4GB) are becomming more common.
> > 
> > But again the last reporters disappeared this time.
> > 
> > I will probably not sent it off before final confirmation again.
> 
> Ok. I'll give it and the rest of the patches a spin on my systems with
> and without Calgary on Sunday.

At least for this patch it would only make sense if you had a VIA box 
with memory >4GB (and most likely it wouldn't have booted before) 

-Andi

