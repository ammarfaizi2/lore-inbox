Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVASMm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVASMm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVASMm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:42:27 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:15755 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261710AbVASMmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:42:25 -0500
Date: Wed, 19 Jan 2005 13:42:24 +0100
From: bert hubert <ahu@ds9a.nl>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1 (and others): heavy disk I/O -> poor performance
Message-ID: <20050119124223.GA14981@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Fabio Coatti <cova@ferrara.linux.it>,
	lkml <linux-kernel@vger.kernel.org>
References: <200501182239.35992.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501182239.35992.cova@ferrara.linux.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 10:39:35PM +0100, Fabio Coatti wrote:
> vmstat under load is the following, and config.gz attached. Of course I can 
> provide any other needed detail; many thanks for any hint.

Looks mightily like DMA is not on, even though you compiled the PIIX driver
in, which lists 
> 0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller 

Can you show the output of hdparm /dev/hda ? Can you show dmesg?


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
