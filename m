Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVEXUdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVEXUdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVEXUdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:33:06 -0400
Received: from isilmar.linta.de ([213.239.214.66]:42632 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262039AbVEXUdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:33:02 -0400
Date: Tue, 24 May 2005 22:33:00 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
Message-ID: <20050524203300.GA24187@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Prakash Punnoor <prakash@punnoor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42935600.5090008@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42935600.5090008@punnoor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 24, 2005 at 06:27:44PM +0200, Prakash Punnoor wrote:
> Hi,
> 
> subject says it all. The cpufreq interface won't show up (using kernel
> 2.6.12-rc4). I tried the speedstep-smi and acpi-cpufreq module. When I try to
> insert one of them, modprobe just report: No such device.

Please compile the kernel with CPUFREQ_DEBUG enabled, boot the kernel with
the option cpufreq.debug=2 and (try to) modprobe both modules again. Then
send me or the cpufreq list (see MAINTAINERS) the output of "dmesg".

	Dominik
