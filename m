Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWGLEkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWGLEkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWGLEkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:40:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:60563 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932191AbWGLEky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:40:54 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="63895205:sNHT37889110"
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
From: Zhu Yi <yi.zhu@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Buesch <mb@bu3sch.de>, Jeff Garzik <jgarzik@pobox.com>,
       jketreno@linux.intel.com, Netdev list <netdev@vger.kernel.org>,
       linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060711133227.GA1650@elf.ucw.cz>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com>
	 <200607102305.06572.mb@bu3sch.de>  <20060711133227.GA1650@elf.ucw.cz>
Content-Type: text/plain
Organization: Intel Corp.
Date: Wed, 12 Jul 2006 12:39:58 +0800
Message-Id: <1152679198.3496.99.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 15:32 +0200, Pavel Machek wrote:
> Probably not. This (very dirty) hack implements that (with some level
> of success -- ifconfig down/ifconfig up is enough to get wireless
> working).

You just need to

$ iwpriv ethX reset

Thanks,
-yi
