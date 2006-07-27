Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWG0Oqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWG0Oqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWG0Oqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:46:52 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:53775 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750705AbWG0Oqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:46:51 -0400
Date: Thu, 27 Jul 2006 10:43:20 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Zhu Yi <yi.zhu@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Buesch <mb@bu3sch.de>,
       Jeff Garzik <jgarzik@pobox.com>, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Message-ID: <20060727144315.GD22935@tuxdriver.com>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <200607102305.06572.mb@bu3sch.de> <20060711133227.GA1650@elf.ucw.cz> <1152679198.3496.99.camel@debian.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152679198.3496.99.camel@debian.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 12:39:58PM +0800, Zhu Yi wrote:
> On Tue, 2006-07-11 at 15:32 +0200, Pavel Machek wrote:
> > Probably not. This (very dirty) hack implements that (with some level
> > of success -- ifconfig down/ifconfig up is enough to get wireless
> > working).
> 
> You just need to
> 
> $ iwpriv ethX reset

I presume that this is sufficient, and I can drop this thread (except
the comment cleanup patch)?

John
-- 
John W. Linville
linville@tuxdriver.com
