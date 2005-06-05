Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVFEUGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVFEUGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFEUGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 16:06:49 -0400
Received: from isilmar.linta.de ([213.239.214.66]:63161 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261605AbVFEUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 16:06:44 -0400
Date: Sun, 5 Jun 2005 19:24:55 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
Message-ID: <20050605172455.GH12338@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Prakash Punnoor <prakash@punnoor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42935600.5090008@punnoor.de> <20050524203300.GA24187@isilmar.linta.de> <42939FAF.8040805@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42939FAF.8040805@punnoor.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> speedstep-smi: signature:0x47534943, command:0x008000b2, event:0x000000b3,
> perf_level:0x07d00100.

Could you try passing the module option "smi_cmd=0x82" to speedstep-smi?
Most often this is the correct value, and in several cases the BIOS reports
false values (in your case: 0x80) which cause speedstep-smi not to work
properly.

Thanks,
	Dominik
