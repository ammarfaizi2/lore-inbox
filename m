Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWCNHy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWCNHy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWCNHy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:54:57 -0500
Received: from fsmlabs.com ([168.103.115.128]:3489 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751668AbWCNHy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:54:56 -0500
X-ASG-Debug-ID: 1142322887-6771-3-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 13 Mar 2006 23:59:03 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zachary Amsden <zach@vmware.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: VMI Interface Proposal Documentation for I386, Part 2.2
Subject: Re: VMI Interface Proposal Documentation for I386, Part 2.2
In-Reply-To: <4415DC3D.4080807@vmware.com>
Message-ID: <Pine.LNX.4.64.0603132357160.11606@montezuma.fsmlabs.com>
References: <4415DC3D.4080807@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9728
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Zachary Amsden wrote:

>     One shortcut we have found most helpful is to simply disable NMI delivery
>     to the paravirtualized kernel.  There is no reason NMIs can't be
>     supported, but typical uses for them are not as productive in a
>     virtualized environment.  Watchdog NMIs are of limited use if the OS is
>     already correct and running on stable hardware; profiling NMIs are
>     similarly of less use, since this task is accomplished with more accuracy
>     in the VMM itself; and NMIs for machine check errors should be handled
>     outside of the VM.  The addition of NMI support does create additional
>     complexity for the trap handling code in the VM, and although the task is
>     surmountable, the value proposal is debatable.  Here, again, feedback
>     is desired.

A guest unmaskable (with programmable interrupt frequency) event would 
certainly be of use and would take care of the majority of NMI users.

Thanks,
	Zwane

