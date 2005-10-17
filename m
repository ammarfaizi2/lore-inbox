Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVJQIQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJQIQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVJQIQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:16:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:26820 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932192AbVJQIQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:16:51 -0400
Subject: Re: Fw: Re: 2.6.14-rc4-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: WU Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051017081534.GA4493@mail.ustc.edu.cn>
References: <20051017001321.2358f341.akpm@osdl.org>
	 <1129533808.7620.70.camel@gaston>  <20051017081534.GA4493@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 18:14:58 +1000
Message-Id: <1129536899.7620.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 16:15 +0800, WU Fengguang wrote:
> On Mon, Oct 17, 2005 at 05:23:27PM +1000, Benjamin Herrenschmidt wrote:
> > Does that updated patch fixes it ?
> Lots of rejects, so I manually applied the relevant part in nv_proto.h.
> It worked, though there were warnings:
> 
> drivers/video/nvidia/nv_setup.c: In function `NVCommonSetup':
> drivers/video/nvidia/nv_setup.c:408: warning: statement with no effect
> drivers/video/nvidia/nv_setup.c:496: warning: statement with no effect
> drivers/video/nvidia/nv_setup.c:504: warning: statement with no effect
> 
> > +#define nvidia_probe_i2c_connector(p, c, edid) (-1)
> > +#define nvidia_probe_of_connector(p, c, edid)  (-1)
> Do you mean TRUE/SUCCESS here with (-1)?

Yes

Ben.


