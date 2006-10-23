Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWJWAwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWJWAwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWJWAwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:52:04 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:40877 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751001AbWJWAwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:52:01 -0400
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Avi Kivity <avi@qumranet.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
X-Message-Flag: Warning: May contain useful information
References: <4537818D.4060204@qumranet.com> <p7364ecm1cl.fsf@verdi.suse.de>
	<adahcxvj2pq.fsf@cisco.com> <200610230239.44764.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 22 Oct 2006 17:51:59 -0700
In-Reply-To: <200610230239.44764.ak@suse.de> (Andi Kleen's message of "Mon, 23 Oct 2006 02:39:44 +0200")
Message-ID: <adad58jj1lc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Oct 2006 00:52:00.0280 (UTC) FILETIME=[729A7180:01C6F63D]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The question is if they all enable VT in the BIOS though. A lot of
 > systems don't and without BIOS support it doesn't work.

Seems to be there on my X60s -- /proc/cpuinfo has:

    model name      : Genuine Intel(R) CPU           L2400  @ 1.66GHz

    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni monitor vmx est tm2 xtpr

(I haven't tried it yet but I assume the vmx flag means it's enabled)

This system is (from dmidecode):

    System Information
            Manufacturer: LENOVO
            Product Name: 1702AT3
            Version: ThinkPad X60s

 - R.
