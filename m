Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274839AbTGaSBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274840AbTGaSBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:01:55 -0400
Received: from smtp0.libero.it ([193.70.192.33]:56312 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S274839AbTGaSBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:01:53 -0400
Subject: Re: 2.6.0-test2, sensors and sysfs
From: Flameeyes <daps_mls@libero.it>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030731211732.5591495d.vsu@altlinux.ru>
References: <1059669362.23100.12.camel@laurelin>
	 <20030731211732.5591495d.vsu@altlinux.ru>
Content-Type: text/plain
Message-Id: <1059674546.1173.14.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 20:02:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 19:17, Sergey Vlasov wrote:
> (Not sure if replying via news.gmane.org will work...)
> 
> Currently (2.6.0-test2) i2c-viapro and via686a don't work together -
> you can use only one of them. This is because they want to work with
> the same PCI device - and having multiple drivers for one device is
> not allowed for obvious reasons.
> 
> This issue is already known to the lm_sensors developers.
> 
> So you will need to remove i2c-viapro for now (but leave i2c-isa);
> then you will see the via686a sensors again.

In this way, I can access all the data of the via686a sensors from the
sysfs without problems (yes, I need a compatible userland, but this
isn't a problem... i can wrote some myself).
I haven't found information about this problem in the post halloween or
in other 2.5 documents, I think is an important thing to know, via686a
chipsets are quite used, AFAIK.

-- 
Flameeyes <dgp85@users.sf.net>

