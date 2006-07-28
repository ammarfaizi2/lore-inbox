Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWG1Nu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWG1Nu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWG1Nu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:50:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:51680 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161146AbWG1Nu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:50:56 -0400
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
References: <20060726141531.A22927@unix-os.sc.intel.com>
	<84EA05E2CA77634C82730353CBE3A84303218F19@SAUSEXMB1.amd.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Jul 2006 15:50:54 +0200
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84303218F19@SAUSEXMB1.amd.com>
Message-ID: <p73slkl4z41.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Langsdorf, Mark" <mark.langsdorf@amd.com> writes:
> 
> If there's a better way to hop to a specific core, I'll
> gladly rewrite the code in question.

You could use smp_call_function_single() 

(i386 version might be only in -mm* so far)

-Andi
