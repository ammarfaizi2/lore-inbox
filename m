Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVLEVMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVLEVMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVLEVMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:12:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32980 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932490AbVLEVMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:12:47 -0500
Date: Mon, 5 Dec 2005 22:12:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David.Ronis@McGill.CA
Cc: linux-kernel@vger.kernel.org
Subject: Re: echo "mem" > /sys/power/state fails
Message-ID: <20051205211232.GA1728@elf.ucw.cz>
References: <1133742700.6492.3.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133742700.6492.3.camel@montroll.chem.mcgill.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 04-12-05 19:31:40, David Ronis wrote:
> I've got a HP laptop (a Pavilion ZV5240CA) running a 2.6.12.6 kernel.
> This as a pentium 4 hyperthreaded chip.
> 
> cat /sys/power/state gives:  standby mem disk 
> 
> echo mem > /sys/power/state as root does nothing.  Nothing appears in
> the logs either.
> 
> Any suggestions?

Try any reasonably new kernel, with cpu hotplug enabled.

-- 
Thanks, Sharp!
