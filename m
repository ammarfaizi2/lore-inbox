Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFJNBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFJNBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFJNBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:01:02 -0400
Received: from mxsf22.cluster1.charter.net ([209.225.28.222]:10443 "EHLO
	mxsf22.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261238AbVFJNA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:00:59 -0400
X-IronPort-AV: i="3.93,189,1115006400"; 
   d="scan'208"; a="989869222:sNHT707798202"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17065.36616.214742.580727@smtp.charter.net>
Date: Fri, 10 Jun 2005 09:00:56 -0400
From: "John Stoffel" <john@stoffel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       James Ketrenos <jketreno@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, vda@ilport.com.ua,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
In-Reply-To: <20050610090022.GF4173@elf.ucw.cz>
References: <200506090909.55889.vda@ilport.com.ua>
	<20050608.231657.59660080.davem@davemloft.net>
	<20050609104205.GD3169@elf.ucw.cz>
	<20050609.125324.88476545.davem@davemloft.net>
	<42A8AE2A.4080104@linux.intel.com>
	<42A8F758.2060008@pobox.com>
	<42A8FF03.3010508@linuxwireless.org>
	<20050610090022.GF4173@elf.ucw.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to chime in here and say that from my point of view, not
enabling the wireless network adaptor until asked by userspace is the
way to go. 

It reduces power requirements, and it pushes the configuration details
out to userspace, where they can be handled according to the policy
setup by the distro/user.

Having my latop bootup and turn on the wireless card and join an AP
without my explicity asking is a bad thing to have happen.  

John
