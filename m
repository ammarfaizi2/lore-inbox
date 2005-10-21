Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVJUQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVJUQgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVJUQgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:36:41 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:36543 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965026AbVJUQgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:36:40 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 21 Oct 2005 19:35:55 +0300
From: Tony Lindgren <tony@atomide.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] TI OMAP driver
Message-ID: <20051021163553.GJ20442@atomide.com>
References: <20051019081906.615365000@omelas> <20051019091717.773678000@omelas> <435613B3.5060509@tremplin-utc.net> <20051019094439.GA12594@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019094439.GA12594@plexity.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Deepak Saxena <dsaxena@plexity.net> [051019 12:45]:
> On Oct 19 2005, at 11:36, Eric Piel was caught saying:
> > >+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 
> > >level)
> > >+{
> > >+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
> > >+
> > >+	return 0;
> > >+}
> > >+
> > >+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 
> > >level)
> > >+{
> > >+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
> > >+
> > >+	return 1;
> > >+}
> > Probably one of them should be called omap_rng_resume() ?
> > 
> > Eric
> 
> Tnx!
> 
> ~Deepak

Cool, works on OMAP OSK after renaming the function above.

Tony
