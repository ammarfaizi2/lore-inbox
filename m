Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUIVUDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUIVUDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUIVUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:03:10 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:33042 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S266833AbUIVUDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:03:06 -0400
Date: Wed, 22 Sep 2004 20:55:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040922205509.09ee1e1d.khali@linux-fr.org>
In-Reply-To: <1095871863.18365.129.camel@localhost>
References: <414F111C.9030809@linuxtv.org>
	<20040921154111.GA13028@kroah.com>
	<41506099.8000307@web.de>
	<41506D78.6030106@web.de>
	<1095843365.18365.48.camel@localhost>
	<1095854048.18365.75.camel@localhost>
	<20040922122848.M14129@linux-fr.org>
	<9e47339104092208403d9de6f4@mail.gmail.com>
	<1095868579.18365.105.camel@localhost>
	<9e4733910409220907727056b4@mail.gmail.com>
	<1095871863.18365.129.camel@localhost>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For my purpose of decoding the EDID read only access is fine. 
> > 
> > But I do know there are programs that use the user space I2C drivers
> > to control extended monitor functions. Some monitors let you set
> > brightnesss, contrast, on/off via the I2C link.
> 
> In which case you will need the current mechanism, with the class
> mechanism to stop sensor drivers probing the bus.

There is no absolute necessity to do that as far as I can see. Usually,
there is nothing on the DDC bus but the DDC EEPROM itself, so the probes
won't happen except for the EEPROM itself, for which it is safe.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
