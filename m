Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968495AbWLER2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968495AbWLER2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968494AbWLER2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:28:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968485AbWLER2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:28:07 -0500
Message-ID: <4575AB54.2050509@redhat.com>
Date: Tue, 05 Dec 2006 12:24:36 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [perfmon] 2.6.19 new perfmon code base + libpfm + pfmon
References: <20061204164644.GO31914@frankl.hpl.hp.com>
In-Reply-To: <20061204164644.GO31914@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Hello,
> 
> I have released another version of the perfmon new code base packages.
> 
> There is no major updates in this version compared to 061127. This is 
> a convenience release so that people can use plain 2.6.19.
> 
> The perfmon2 kernel changes are:
> 	- fix UP exit bug in system-wide mode where the active context
> 	  accounting was done incorrectly.
> 	- MIPS update to correct register hardware addresses (Phil Mucci)
> 
> I have also released a new libpfm, libpfm-3.2-061204 with the
> following changes:
> 	- updated MIPS processor detection code
> 
> Also a new version of pfmon, pfmon-3.2-061204 with the following changes:
> 	- fix various perfmon v2.0 compatibility bugs for IA-64
> 	- fortify return values for read() (will Cohen)
> 	
> Both libpfm and pfmon releases work with kernel-patch 061127 or 061204.
> 
> You can grab the new packages at our web site:
> 
> 	 http://perfmon2.sf.net
> 
> Enjoy,
> 

Some of the ptrace functions (e.g. ptrace_may_attach in perfmon_syscall.c) 
being used in the perfmon kernel patches will go away with the utrace patches: 
http://people.redhat.com/roland/utrace/


-Will
