Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVAUUkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVAUUkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAUUkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:40:06 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:48269 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S262504AbVAUUh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:37:58 -0500
Date: Fri, 21 Jan 2005 17:25:30 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jun.nakajima@intel.com, venkatesh.pallipadi@intel.com,
       nanhai.zou@intel.com
Subject: Re: [BUG?]: cpufreqency scaling - wrong frequency detected
Message-ID: <20050121162530.GB8435@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jun.nakajima@intel.com, venkatesh.pallipadi@intel.com,
	nanhai.zou@intel.com
References: <41F010C9.6040201@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F010C9.6040201@tiscali.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I hope this information can help you. I don't know if it's really a bug, 

yes, this seems to be a bug.

> so I send it to the mailing list instead of reporting it to the bugzilla 
> bugtracking system. if you need additional information, I'll compile a 
> Kernel with cpufreq debugging.

Unfortunately, this seems to be necessary. Please re-compile with cpufreq
debugging enabled, pass cpufreq.debug=2 on the kernel boot line, and send me
the dmesg (off-list).

Thanks,
	Dominik
