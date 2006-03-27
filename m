Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWC0Wd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWC0Wd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWC0Wd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:33:58 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:38172 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751169AbWC0Wd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:33:57 -0500
Date: Mon, 27 Mar 2006 15:34:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, lm-sensors@lm-sensors.org,
       r.marek@sh.cvut.cz, khali@linux-fr.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85 chips to m41t00 driver
Message-ID: <20060327223438.GA21077@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012406.GE9560@mag.az.mvista.com> <20060326145840.5e578fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326145840.5e578fa4.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Mar 26, 2006 at 02:58:40PM -0800, Andrew Morton wrote:
> "Mark A. Greer" <mgreer@mvista.com> wrote:
> >
> >  +	struct i2c_msg msgs[] = {
> >  +		{ save_client->addr, 0, 1, msgbuf },
> >  +		{ save_client->addr, I2C_M_RD, 8, buf }
> 
> The
> 
> 	.name = value,
> 
> form would be preferred.  It reduces the possibility of silent breakage if
> someone changes struct i2c_msg.

Noted.  Will fix in upcoming set of new patches.

Mark
