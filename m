Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTDDB7Q (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 20:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTDDB7Q (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 20:59:16 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:48612 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263610AbTDDB7K (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 20:59:10 -0500
Date: Fri, 4 Apr 2003 12:11:52 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: frodol@dds.nl, phil@netroedge.com, Greg KH <greg@kroah.com>
Subject: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030404021152.GE466@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and she still can't stop grinning. 

Basically I've tracked down the poweroffs on my system using the stock
kernel. I'm now running what is basically a slightly reduced config
whose only real difference with the crashing one (that I build along the
way - 20 kernels in total) was the i2c code.

The majorly big email I sent describing exactly what happens is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104860726612212&w=2

I2C components that were compiled in:

-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_PIIX4=y
-CONFIG_I2C_PROC=y
-CONFIG_SENSORS_ADM1021=y

Please help. I like knowing what temp my cpu is at. :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
