Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVAaWEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVAaWEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVAaWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:04:07 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:13841 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261376AbVAaWEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:04:00 -0500
Date: Mon, 31 Jan 2005 23:04:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050131230416.59daa051.khali@linux-fr.org>
In-Reply-To: <20050131214622.GF21437@stusta.de>
References: <20050131185955.GA18316@stusta.de>
	<20050131215050.61c2924c.khali@linux-fr.org>
	<20050131214622.GF21437@stusta.de>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> > > -struct bus_type i2c_bus_type = {
> > > -	.name =		"i2c",
> > > -	.match =	i2c_device_match,
> > > -	.suspend =      i2c_bus_suspend,
> > > -	.resume =       i2c_bus_resume,
> > > -};
> > (...)
> > 
> > Is moving that code around really necessary? Looks to me like only
> > the i2c_bus_type structure needs to be moved.
> 
> i2c_bus_type requires i2c_device_match, i2c_bus_suspend and 
> i2c_bus_resume...

Oops, seems I missed the obvious here :/

Sorry for the noise. I guess I better get some sleep now...

-- 
Jean Delvare
