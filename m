Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWHYPYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWHYPYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWHYPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:24:45 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:30930 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1422712AbWHYPYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:24:44 -0400
Date: Fri, 25 Aug 2006 08:10:43 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060825151043.GK5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <200608251513.58729.ak@suse.de> <20060825142759.GH5330@frankl.hpl.hp.com> <200608251653.52898.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608251653.52898.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Aug 25, 2006 at 04:53:52PM +0200, Andi Kleen wrote:
> On Friday 25 August 2006 16:27, Stephane Eranian wrote:
> 
> > I think I will drop the EXCL_IDLE feature given that most PMU stop
> > counting when you go low-power. The feature does not quite do what
> > we want because it totally exclude the idle from monitoring, yet
> > the idle may be doing useful kernel work, such as fielding interrupts.
> 
> Ok fine. Anything that makes the code less complex is good.
> Currently it is very big and hard to understand.
> 
> (actually at least one newer Intel system I saw seemed to continue counting
> in idle, but that might have been a specific quirk)
> 
How is this affecting your RDTSC "emulation" with perfctr0?

-- 

-Stephane
