Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265221AbUETVf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUETVf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUETVf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:35:29 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22170 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265221AbUETVfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:35:25 -0400
Date: Thu, 20 May 2004 23:29:57 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Laurent Goujon <laurent.goujon@online.fr>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
Subject: Re: Sluggish performances with FreeBSD
Message-ID: <20040520232957.A2172@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org> <20040520193406.GA16184@ss1000.ms.mff.cuni.cz> <1085083195.4240.4.camel@caribou.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1085083195.4240.4.camel@caribou.no-ip.org>; from laurent.goujon@online.fr on Thu, May 20, 2004 at 09:59:55PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Goujon <laurent.goujon@online.fr> :
> In ifconfig stats, I have no error, no overruns or dropped packets.
> And remove the acpi modules have no effect...

- same thing if the acpi module is not inserted _at all_ during the boot ?
- how do you stress the network pipe ? 
- you probably want to provide detailled ethtool/lspci -vx output, 
  (complete) dmesg from the boot sequence and vmstat 1 during your tests.
  /proc/interrupts can't hurt either

Please consider a follow-up of the thread on netdev@oss.sgi.com

--
Ueimor
