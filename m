Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTGBMD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTGBMD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:03:58 -0400
Received: from leto.uk.clara.net ([195.8.69.187]:19217 "EHLO leto.uk.clara.net")
	by vger.kernel.org with ESMTP id S264952AbTGBMD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:03:57 -0400
Date: Wed, 2 Jul 2003 13:18:20 +0100
From: Faye Pearson <faye@zippysoft.com>
To: linux-kernel@vger.kernel.org
Subject: pppd pppoatm multilink?
Message-ID: <20030702121820.GA21592@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.21 on an i686
User-Agent: Mutt/1.5.4i
X-Clarascan: Mail did not trigger 'vscan' scanning module
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ISP is about to trial multilink ADSL for use with routers like the
Cisco 1600, but I was wondering if it could be done 'on the cheap' (well
relatively anyway) with a linux box and a couple of PCI ADSL modems.

AIUI it should work the same as MP using two ttyS devices but 
first glance suggests this won't work, the pppoatm module for pppd
seems to take the VPI.VCI as the device and there doesn't seem to
be any way to say which physical ATM device to use.  The VPI.VCI
would be the same at both interfaces.  Does it just pick the
first available ATM device?  Or just the first ATM device?

Thanks

Faye.

Please also cc: me in on replies, thank you.
