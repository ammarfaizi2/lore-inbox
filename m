Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTBRDoH>; Mon, 17 Feb 2003 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTBRDoG>; Mon, 17 Feb 2003 22:44:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:64320
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267577AbTBRDoG>; Mon, 17 Feb 2003 22:44:06 -0500
Date: Mon, 17 Feb 2003 22:52:35 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][2.5] IRQ distribution patch for 2.5.58
In-Reply-To: <20030217181614.GP29983@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0302172244270.25630-100000@montezuma.mastecende.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com>
 <20030217181614.GP29983@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, William Lee Irwin III wrote:

> On Thu, Jan 16, 2003 at 01:08:55PM -0800, Kamble, Nitin A wrote:
> > +		spin_lock(&desc->lock);
> > +		irq_balance_mask[selected_irq] = target_cpu_mask;
> > +		spin_unlock(&desc->lock);
> 
> Wrong.

The desc locking for irq_balance_mask looks very strange,  what made you 
put it in?

	Zwane
-- 
function.linuxpower.ca
