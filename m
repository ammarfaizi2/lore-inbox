Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbUCZMCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUCZMCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:02:43 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:29398 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264025AbUCZMCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:02:37 -0500
Date: Fri, 26 Mar 2004 13:02:36 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] disapearing routing entries
Message-ID: <20040326120236.GB22185@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
	kernel list <linux-kernel@vger.kernel.org>
References: <200403261033.i2QAXgii022013@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403261033.i2QAXgii022013@green.mif.pg.gda.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 11:33:42AM +0100, Andrzej Krzysztofowicz wrote:
> Hi,
> 
> I sometimes notice while using different 2.4/2.2 kernels that some static
> route entries tend to disappear suddenly few days after they are manually
> added. It happens only to manually added (non-automatic) entries.
> No messages concerning this are found in dmesg and system logs.

Make doubly sure you are not running routed, gated or zebra/quagga,
userspace tools which change your routing.

Regards,
bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
