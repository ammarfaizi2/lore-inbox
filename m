Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVANVI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVANVI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVANVIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:08:39 -0500
Received: from mailout.zma.compaq.com ([161.114.64.104]:6415 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262134AbVANVHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:07:55 -0500
Date: Fri, 14 Jan 2005 15:07:50 -0600
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Atro.Tossavainen@helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: CCISS problems continue with 2.4.28
Message-ID: <20050114210750.GA24705@beardog.cca.cpqcorp.net>
References: <200501121008.j0CA8uX5013590@kruuna.helsinki.fi> <20050112105045.GB30115@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112105045.GB30115@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:50:45AM -0200, Marcelo Tosatti wrote:
> On Wed, Jan 12, 2005 at 12:08:56PM +0200, Atro Tossavainen wrote:
> > (Attn mikem, really.)
> > 
> > Upgraded the Proliant DL380 (see lkml traffic from mid-November 2004)
> > to 2.4.28.  The cciss partition lookup freezes just the same as before.
> > 2.4.26 is still the most recent 2.4 series kernel that will boot.
> 
> Mike? 
Sorry, I let this one drop though the cracks. Try booting with acpi=off. It appears the interrupt is not being detected properly. If acpi=off works try updating the system ROM. We have been known to have buggy acpi tables.

Again, sorry for the delay,
mikem
