Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTIBVwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTIBVwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:52:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:3267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263844AbTIBVwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:52:33 -0400
Date: Tue, 2 Sep 2003 14:50:06 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1169] New: Consistently getting oops when trying standby
 or mem 
In-Reply-To: <910000.1062201628@[10.10.2.4]>
Message-ID: <Pine.LNX.4.33.0309021449180.1737-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Aug 2003, Martin J. Bligh wrote:

> http://bugme.osdl.org/show_bug.cgi?id=1169
> 
>            Summary: Consistently getting oops when trying standby or mem
>     Kernel Version: arjan's kernel-2.6.0-0.test4.1.32 rpms
>             Status: NEW
>           Severity: normal
>              Owner: len.brown@intel.com
>          Submitter: richard.torkar@htu.se
> 
> 
> Distribution: rh9
> Hardware Environment: DELL latitude L400 laptop, BIOS A09, 
> Software Environment:
> Problem Description:
> Whenever I try to use acpi and standby my computer throws an oops. Same thing
> happens when I try to use cat "mem" > /sys/power/state
> 
> Steps to reproduce:
> cat "mem" > /sys/power/state
> or
> cat "standby" > /sys/power/state

This should be fixed in the latest -test4-mm4 tree. Could the submitter 
please try that kernel and report whether it works or not? 

Thanks,


	Pat

