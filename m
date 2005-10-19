Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVJSJpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVJSJpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVJSJpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:45:13 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:60097 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964771AbVJSJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:45:11 -0400
Date: Wed, 19 Oct 2005 02:44:39 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] TI OMAP driver
Message-ID: <20051019094439.GA12594@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051019081906.615365000@omelas> <20051019091717.773678000@omelas> <435613B3.5060509@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435613B3.5060509@tremplin-utc.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19 2005, at 11:36, Eric Piel was caught saying:
> >+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 
> >level)
> >+{
> >+	omap_rng_write_reg(RNG_MASK_REG, 0x0);
> >+
> >+	return 0;
> >+}
> >+
> >+static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 
> >level)
> >+{
> >+	omap_rng_write_reg(RNG_MASK_REG, 0x1);
> >+
> >+	return 1;
> >+}
> Probably one of them should be called omap_rng_resume() ?
> 
> Eric

Tnx!

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
