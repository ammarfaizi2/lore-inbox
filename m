Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbULGI1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbULGI1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbULGI1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:27:09 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32908 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261570AbULGI1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:27:06 -0500
Date: Tue, 7 Dec 2004 09:26:51 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Johan <johan@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of via velocity in 2.6.9
Message-ID: <20041207082651.GB24306@electric-eye.fr.zoreil.com>
References: <41B4F447.2060808@ccs.neu.edu> <20041207004400.GC12838@electric-eye.fr.zoreil.com> <41B5061B.1010004@ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B5061B.1010004@ccs.neu.edu>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan <johan@ccs.neu.edu> :
[...]
> 3. I would love to provide any debugging output, but don't know how. 
> Please be more specific.  A pointer to the proper FAQ will suffice.
> 
> There is is no discernable error message: at least not to console or to 
> /var/log/messages.  It just stops sending or receiving.

See REPORTING-BUGS for some hints. ethtool output before/after problem can
be added. It surprises me that the TX watchdog does not trigger if the device
stops working. Anything like a cron which could take place during the
5 minutes ? ifconfig and /proc/interrupts does not evolve any more once the
traffic is stopped ?

Cc: on netdev@oss.sgi.com is welcome.

--
Ueimor
