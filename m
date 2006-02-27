Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWB0MXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWB0MXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWB0MXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:23:32 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:64405 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751831AbWB0MXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:23:31 -0500
Date: Mon, 27 Feb 2006 17:53:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: balbir@in.ibm.com, dipankar@in.ibm.com,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 4/7] Add sysctl for delay accounting
Message-ID: <20060227122323.GA3980@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141028322.5785.60.camel@elinux04.optonline.net> <1141028784.2992.58.camel@laptopd505.fenrus.org> <4402BA93.5010302@watson.ibm.com> <1141029743.2992.71.camel@laptopd505.fenrus.org> <20060227090414.GA18941@in.ibm.com> <1141031595.2992.76.camel@laptopd505.fenrus.org> <20060227101124.GA22492@in.ibm.com> <1141039458.2992.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141039458.2992.94.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:24:18PM +0100, Arjan van de Ven wrote:
> well you assume you CAN walk all tasks... which is something afaik
> that's being deprecated ;)

CPU Hotplug (migrate_live_tasks) also depends on walking all tasks atleast. 
Wonder how that would need to change if we can't do that.

-- 
Regards,
vatsa
