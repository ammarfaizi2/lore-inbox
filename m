Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVALUgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVALUgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVALU1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:27:38 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:55308 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261391AbVALUVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:21:01 -0500
Date: Wed, 12 Jan 2005 21:23:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stian Jordet <liste@jordet.nu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: i2c_adapter i2c-0: Bus collision!
Message-Id: <20050112212316.44efcedb.khali@linux-fr.org>
In-Reply-To: <1105461895.8299.2.camel@localhost.localdomain>
References: <1073527236.624.7.camel@buick>
	<1073707567.621.5.camel@buick>
	<1074304828.780.2.camel@chevrolet.hybel>
	<20040117094856.2f8b44c8.khali@linux-fr.org>
	<1105461895.8299.2.camel@localhost.localdomain>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stian,

> about a year ago I asked for help with my motherboard, claiming i2c
> bus collisions all the time. Now I found the solution, the sensor uses
> the isa bus, not the i2c. Funny it sometimes worked with i2c-viapro,
> but with i2c-isa it works all the time :)

Thanks a lot for keeping us informed.

Too bad you did not tell us you had the possibility to use the ISA
access in the first place. It is well known that ISA access is more
reliable than SMBus or I2C.

It also might explain why MBM was working without a problem. I suppose
it was also using the ISA interface, same as you do now.

-- 
Jean Delvare
http://khali.linux-fr.org/
