Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUITAIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUITAIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUITAIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:08:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:33724 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265106AbUITAIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:08:51 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040919091252baeb1a@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040918195807.18874.qmail@web11906.mail.yahoo.com>
	 <9e47339104091815125ef78738@mail.gmail.com>
	 <1095569317.6670.26.camel@gaston>
	 <9e473391040919091252baeb1a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095638860.18428.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 10:07:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 02:12, Jon Smirl wrote:

> The radeon driver has that extra code for intializing older DDC. That
> can be handled generically in the I2C layer by writing a ddc driver
> that is a superset of the eeprom driver.  I'd rather get that code
> into a generic driver than repeat it in every video card driver.

I'm not a fan of this solution as you know... oh well... and there's
all that code to detect non-DDC capable monitors as well, which won't
go through /sys/*/i2c...

But do as you like, I don't have time to work on it so I'll shut up.

Ben.


