Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWAQNIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWAQNIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAQNIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:08:51 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57002 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932455AbWAQNIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:08:50 -0500
Message-ID: <43CCEC5F.7020801@pobox.com>
Date: Tue, 17 Jan 2006 08:08:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH ] ethtool: Remove duplex info from CTRL register dump
References: <20060112071642.29428.23880.stgit@Gecko.tarbal.com>
In-Reply-To: <20060112071642.29428.23880.stgit@Gecko.tarbal.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jeff Kirsher wrote: > The duplex control register is
	used for setting the driver and is not > necessary for debug purposes.
	The value of the duplex control register is > what the register's
	current value is and may not reflect the correct status > of te current
	connection. That is what the duplex status register is used > for. To
	keep from confusing the user, we are removing the duplex register >
	from the ethtool dump of the registers. > > Signed-off-by: Jeff Kirsher
	<jeffrey.t.kirsher@intel.com> > Signed-off-by: Jesse Brandeburg
	<jesse.brandeburg@intel.com> > Signed-off-by: John Ronciak
	<john.ronciak@intel.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Kirsher wrote:
> The duplex control register is used for setting the driver and is not
> necessary for debug purposes.  The value of the duplex control register is
> what the register's current value is and may not reflect the correct status
> of te current connection.  That is what the duplex status register is used
> for.  To keep from confusing the user, we are removing the duplex register
> from the ethtool dump of the registers.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: John Ronciak <john.ronciak@intel.com>

applied, after replacing "ethtool:" with "e1000:" in the subject line.

	Jeff



