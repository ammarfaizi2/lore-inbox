Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUFNHNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUFNHNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 03:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUFNHNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 03:13:31 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:61194 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S261976AbUFNHNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 03:13:30 -0400
From: Meelis Roos <mroos@linux.ee>
To: nahidesafe-linux@yahoo.it, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Toshiba 1800-100 linux-2.6.x Driver for the SMC Infrared Communications Controller does not work
In-Reply-To: <40CC1A93.6040808@yahoo.it>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.7-rc3 (i686))
Message-Id: <E1BZle8-00035D-Cs@rhn.tartu-labor>
Date: Mon, 14 Jun 2004 10:12:44 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S> Toshiba 1800-100 linux-2.6.x Driver for the SMC Infrared Communications
S> Controller does not work

It's a known problem. The reason is that Toshiba BIOS does not enable
the SMC irda controller. You can verify it useing lspnp -v (at least I
can on my 1800-314). If you enable the device by hand, it will work.

There is a Linux program for enabling the irda controller, look at
http://www.csai.unipa.it/peri/toshsat1800-irdasetup/ .

The setup can problaby be made also from kernel but the main question is
how to autodetect the need for this setup.

-- 
Meelis Roos
