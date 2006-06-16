Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWFPMlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWFPMlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFPMlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:41:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51368 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751384AbWFPMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:41:35 -0400
Message-ID: <4492A6E6.3090805@sgi.com>
Date: Fri, 16 Jun 2006 14:41:10 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de> <44928FB1.5070107@sgi.com> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com> <4492A5E4.9050702@bull.net>
In-Reply-To: <4492A5E4.9050702@bull.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:
> Just to make sure I understand it correctly...
> Assuming I have allocated per CPU data (numa control, etc.) pointed at by:

I think you misunderstood - vgetcpu is for userland usage, not within
the kernel.

Cheers,
Jes
