Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVALUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVALUtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVALUpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:45:04 -0500
Received: from [82.147.40.124] ([82.147.40.124]:64640 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S261378AbVALUmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:42:10 -0500
Subject: Re: i2c_adapter i2c-0: Bus collision!
From: Stian Jordet <liste@jordet.nu>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112212316.44efcedb.khali@linux-fr.org>
References: <1073527236.624.7.camel@buick> <1073707567.621.5.camel@buick>
	 <1074304828.780.2.camel@chevrolet.hybel>
	 <20040117094856.2f8b44c8.khali@linux-fr.org>
	 <1105461895.8299.2.camel@localhost.localdomain>
	 <20050112212316.44efcedb.khali@linux-fr.org>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 21:41:51 +0100
Message-Id: <1105562511.4811.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 12,.01.2005 kl. 21.23 +0100, skrev Jean Delvare:
> Hi Stian,
> 
> > about a year ago I asked for help with my motherboard, claiming i2c
> > bus collisions all the time. Now I found the solution, the sensor uses
> > the isa bus, not the i2c. Funny it sometimes worked with i2c-viapro,
> > but with i2c-isa it works all the time :)
> 
> Thanks a lot for keeping us informed.
> 
> Too bad you did not tell us you had the possibility to use the ISA
> access in the first place. It is well known that ISA access is more
> reliable than SMBus or I2C.
> 
> It also might explain why MBM was working without a problem. I suppose
> it was also using the ISA interface, same as you do now.

Believe me, had I known it, I would have told you :) Anyway, a happy
ending :) Thanks for your support.

Best regards,
Stian

