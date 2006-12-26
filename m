Return-Path: <linux-kernel-owner+w=401wt.eu-S932643AbWLZQMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWLZQMD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWLZQMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:12:01 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:35050 "EHLO outpost.ds9a.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932643AbWLZQMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:12:01 -0500
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 11:12:00 EST
Date: Tue, 26 Dec 2006 16:45:24 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: bcm43xx-softmac broken on 2.6.20-rc2
Message-ID: <20061226154524.GB12583@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
	netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org
References: <458EA216.7000101@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458EA216.7000101@lwfinger.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2006 at 09:51:50AM -0600, Larry Finger wrote:
> This is a heads-up for anyone wishing to use bcm43xx-softmac on Linus's git 
> tree, which is now at
> v2.6.20-rc2. There are two serious bugs in that code. Fixes are found below.

For some reason your patch does not apply to stock 2.6.20-rc2, although I
don't see why. Applying it by hand makes things compile though, and even
fixes the problem I mentioned in my previous post:

http://www.spinics.net/lists/netdev/msg21906.html

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
