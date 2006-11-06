Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753681AbWKFRuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbWKFRuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbWKFRuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:50:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753610AbWKFRuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:50:39 -0500
Date: Mon, 6 Nov 2006 12:49:28 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christian <christiand59@web.de>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061106174928.GB19283@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Christian <christiand59@web.de>,
	Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com> <200611051832.13285.christiand59@web.de> <20061105200448.GE859@redhat.com> <20061106173528.GQ5778@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106173528.GQ5778@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 06:35:28PM +0100, Adrian Bunk wrote:
 
 > config X86_POWERNOW_K8
 >         tristate "AMD Opteron/Athlon64 PowerNow!"
 >         select CPU_FREQ_TABLE
 > 	depends (ACPI_PROCESSOR || ACPI_PROCESSOR=n)
 > 
 > But in the end, the best solution depends on how many percent of the 
 > X86_POWERNOW_K8 users have Christian's problem of requiring 
 > ACPI_PROCESSOR. If there are only very few people with this problem, I'd 
 > say leave it as it is.

Well, it's been this way for a while, and only recently this has come up.
There was a similar report for powernow-k7, which has a similar construct.

	Dave

-- 
http://www.codemonkey.org.uk
