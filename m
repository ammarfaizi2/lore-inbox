Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWCFTGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCFTGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWCFTGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:06:18 -0500
Received: from pat.qlogic.com ([198.70.193.2]:35454 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932262AbWCFTGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:06:16 -0500
Date: Mon, 6 Mar 2006 11:06:14 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: Stefan Kaltenbrunner <mm-mailinglist@madness.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: problems with scsi_transport_fc and qla2xxx
Message-ID: <20060306190614.GM6278@andrew-vasquezs-powerbook-g4-15.local>
References: <1413265398.20060227150526@netvision.net.il> <978150825.20060227210552@netvision.net.il> <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at> <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il> <20060302173846.GF498@andrew-vasquezs-powerbook-g4-15.local> <862131446.20060303011539@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <862131446.20060303011539@netvision.net.il>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Mar 2006 19:06:15.0771 (UTC) FILETIME=[0AE712B0:01C64151]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2006, Maxim Kozover wrote:

> Please see the log with debug-patch.
> The module is loaded with option qlport_down_retry=1.
> Adapter 4 is connected to switch, adapter 5 doesn't have cable attached.
> After reconnecting the cable the disks don't reappear and rescan is stuck.
> Before applying your patches ghost rport was staying, now it's OK.

Before you try the patch I sent earlier, could you send be the output
from the following:

	# echo t > /proc/sysrq-trigger

Thanks,
Andrew Vasquez
