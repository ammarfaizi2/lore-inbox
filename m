Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWJ1JwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWJ1JwH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 05:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWJ1JwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 05:52:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:14229 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752033AbWJ1JwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 05:52:04 -0400
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 02:46:41 -0700
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <20061027234615.791b3942.akpm@osdl.org> <20061028064924.GA9127@hockin.org>
In-Reply-To: <20061028064924.GA9127@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610280246.42384.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nothing at all, or just the the low few bits are writeable?  I had heard,
> but never seen that some Intel CPUs only allowed 16 bits of writable bits
> in the TSC MSR.  I also heard of, but never saw, CPUs that cleared the TSC
> to 0 on a write!

Normally on Intel you can only write the first 32bits

-Andi

