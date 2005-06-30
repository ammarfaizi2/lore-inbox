Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVF3I0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVF3I0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3I0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:26:30 -0400
Received: from colin.muc.de ([193.149.48.1]:23827 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262900AbVF3I02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:26:28 -0400
Date: 30 Jun 2005 10:26:27 +0200
Date: Thu, 30 Jun 2005 10:26:27 +0200
From: Andi Kleen <ak@muc.de>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk, ncunningham@cyclades.com, pavel@ucw.cz
Subject: Re: [PATCH]MTRR suspend/resume cleanup
Message-ID: <20050630082627.GA88410@muc.de>
References: <1119936124.3158.9.camel@linux-hp.sh.intel.com> <20050627222444.370457d4.akpm@osdl.org> <1120097601.2942.6.camel@linux-hp.sh.intel.com> <20050629190832.40134f7c.akpm@osdl.org> <1120098268.3235.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120098268.3235.2.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There has been some discuss about solving the SMP MTRR suspend/resume
> breakage, but I didn't find a patch for it. This is an intent for it.
> The basic idea is moving mtrr initializing into cpu_identify for all APs
> (so it works for cpu hotplug). For BP, restore_processor_state is
> responsible for restoring MTRR.

Looks good to me. Thanks.

-Andi
