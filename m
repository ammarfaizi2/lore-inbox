Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUGFFpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUGFFpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 01:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUGFFpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 01:45:55 -0400
Received: from bender.bawue.de ([193.7.176.20]:17612 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263088AbUGFFpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 01:45:53 -0400
Date: Tue, 6 Jul 2004 07:45:46 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Len Brown <len.brown@intel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: System not booting after acpi_power_off()
Message-ID: <20040706054546.GA5016@sommrey.de>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <A6974D8E5F98D511BB910002A50A6647615FF35A@hdsmsx403.hd.intel.com> <1089059128.15675.77.camel@dhcppc4> <20040705210420.GA23177@sommrey.de> <1089062436.15675.128.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089062436.15675.128.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 05:20:36PM -0400, Len Brown wrote:
> Hmm, I don't see any messages from the button driver,
> do you have CONFIG_ACPI_BUTTON enabled?
> If yes, can you send me the output
> from acpidmp?  acpidmp is in /usr/sbin
> or in pmtools: 
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Oops, that's not obvious: from config help I got the impression, the
button module wasn't of any use at this time.  After loading the button
module everything works fine.  

Thanks a lot,
-jo

-- 
-rw-r--r--    1 jo       users          80 2004-07-06 07:35 /home/jo/.signature
