Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWG3S7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWG3S7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWG3S7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:59:11 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:29387 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932435AbWG3S7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:59:10 -0400
Date: Sun, 30 Jul 2006 20:58:51 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3 does not like an old udev (071)
Message-ID: <20060730185850.GA31155@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Guillaume Chazarain <guichaz@yahoo.fr>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <44CCEC96.3020607@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CCEC96.3020607@yahoo.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 07:29:58PM +0200, Guillaume Chazarain wrote:

> When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86, 
> /dev/usblp0
> is no more created on boot. If I manually create it, it works fine.

I can confirm this exact problem.

> git-bisect told me the culprit was
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a

Thanks for doing the work, Guillaume! I was trying to find the time to do
the same.

> Updating udev to 096, and using a normal 2.6.18-rc3 kernel works too, so
> maybe the correct (albeit unpopular) fix is to update the udev requirement
> in Documentation/Changes?

I hope this won't be necessary..

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
