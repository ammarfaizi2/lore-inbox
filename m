Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbVF3Uu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbVF3Uu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbVF3Uuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:50:50 -0400
Received: from isilmar.linta.de ([213.239.214.66]:49319 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S263159AbVF3UuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:50:23 -0400
Date: Thu, 30 Jun 2005 22:50:17 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: john stultz <johnstul@us.ibm.com>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/] timers: tsc using for cpu scheduling
Message-ID: <20050630205017.GB5437@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	john stultz <johnstul@us.ibm.com>,
	"Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <6EDC9204B3704C4C8522539D5C1185E5019D060F@mssmsx403.ccr.corp.intel.com> <1120158468.24889.150.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120158468.24889.150.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:07:48PM -0700, john stultz wrote:
> Well, not quite. First of all, I believe (Dominik would know better)
> that not all CPUs that support frequency scaling actually modify their
> TSC frequency. So in some cases the TSC is time and in others it is
> work.

Indeed. For example, P4s capable of Enhanced SpeedStep do not modify the TSC
tick rate.

	Dominik
