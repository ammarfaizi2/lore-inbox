Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGTRF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGTRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUGTRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:05:29 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:4329 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266014AbUGTRFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:05:24 -0400
Message-ID: <40FD50DB.9080708@backtobasicsmgmt.com>
Date: Tue, 20 Jul 2004 10:05:31 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc2 - ACPI still broken
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> <1090333194.2368.6.camel@forum-beta.geizhals.at> <20040720165855.GB19102@unicorn.sch.bme.hu>
In-Reply-To: <20040720165855.GB19102@unicorn.sch.bme.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:

> On Tue, Jul 20, 2004 at 04:19:54PM +0200, Thomas Zehetbauer wrote:
> 
>>ACPI support is still broken for the Intel D865PERL board. Booting hangs
>>when compiled for SMP/HT and succeeds only with acpi=off or acpi=ht boot
>>parameter.
> 
> 
> It is still broken for Intel D865GRH too, as I reported first using 
> 2.6.7-rc3.

There is a new patch in the RedHat Bugzilla that fixes this problem (it 
restricts one of the ACPI setup events to only run on CPU 0). Hopefully 
it will get merged into the kernel tree soon, although all the 
developers are at OLS this week :-(
