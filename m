Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUIVQJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUIVQJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUIVQI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:08:58 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:43627 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266195AbUIVQHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:07:50 -0400
Message-ID: <9e4733910409220907727056b4@mail.gmail.com>
Date: Wed, 22 Sep 2004 12:07:29 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1095868579.18365.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de> <41506D78.6030106@web.de>
	 <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org>
	 <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
	 <9e47339104092208403d9de6f4@mail.gmail.com>
	 <1095868579.18365.105.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 16:56:19 +0100, Adrian Cox <adrian@humboldt.co.uk> wrote:
> Would it do for a display device to expose read-only EDID data through
> sysfs, or do you need I2C level access to DDC from userspace?

For my purpose of decoding the EDID read only access is fine. 

But I do know there are programs that use the user space I2C drivers
to control extended monitor functions. Some monitors let you set
brightnesss, contrast, on/off via the I2C link.

-- 
Jon Smirl
jonsmirl@gmail.com
