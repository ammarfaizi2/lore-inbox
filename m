Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbTLIUEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTLIUEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:04:14 -0500
Received: from palace.clanhk.org ([64.5.48.96]:33256 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265208AbTLIUEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:04:09 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
Reply-To: heretic@clanhk.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Tue, 9 Dec 2003 13:59:24 -0600
User-Agent: KMail/1.5.4
References: <20031203204445.GA26987@gtf.org>
In-Reply-To: <20031203204445.GA26987@gtf.org>
Organization: Clan [HK]
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091359.24546.heretic@clanhk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 December 2003 02:44 pm, Jeff Garzik wrote:
> Queueing support
> 3) "Native Command Queueing" -- both host and drive cooperate in the
> queueing and execution of drive commands.  This should provide the
> highest performance and lowest latency of all three options.

Has anyone gotten their hands on any Silicon Image 3124 hardware?  It was 
announced 3 months ago and supports PCI-X plus it's designed to support 
whatever the final SATA 2.0 spec ends up being.  Full NCQ support.

http://www.siliconimage.com/products/sii3124.asp

> Hotplug support
> ---------------
> All SATA is hotplug.
>
> libata does not support hotplug... yet.

Hot-Plug seems like one of the most universally supported features.  What will 
it take to get it working?  And what will it take to get it working on 2.4?  
Is that a major feature we'll just have to wait for in libata?

I personally need hot-swap on production servers.

-ryan

