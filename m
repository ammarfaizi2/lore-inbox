Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTBREGd>; Mon, 17 Feb 2003 23:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTBREGc>; Mon, 17 Feb 2003 23:06:32 -0500
Received: from holomorphy.com ([66.224.33.161]:61072 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267588AbTBREGc>;
	Mon, 17 Feb 2003 23:06:32 -0500
Date: Mon, 17 Feb 2003 20:15:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.5] IRQ distribution patch for 2.5.58
Message-ID: <20030218041535.GQ29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	"Kamble, Nitin A" <nitin.a.kamble@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com> <20030217181614.GP29983@holomorphy.com> <Pine.LNX.4.50.0302172244270.25630-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302172244270.25630-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 01:08:55PM -0800, Kamble, Nitin A wrote:
+		spin_lock(&desc->lock);
+		irq_balance_mask[selected_irq] = target_cpu_mask;
+		spin_unlock(&desc->lock);

On Mon, 17 Feb 2003, William Lee Irwin III wrote:
>> Wrong.

On Mon, Feb 17, 2003 at 10:52:35PM -0500, Zwane Mwaikambo wrote:
> The desc locking for irq_balance_mask looks very strange,  what made you 
> put it in?

I only quoted the patch. I've got enough going wrong with hackers
running wild and stuffing bitmasks, ASCII art, and possibly even JPEG's
into my RTE's without changing thelocking.


-- wli
