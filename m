Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWG0TlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWG0TlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWG0TlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:41:21 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24865 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750731AbWG0TlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:41:21 -0400
Date: Thu, 27 Jul 2006 13:41:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <mH3yg.16777$2u4.7977@trnddc06>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44C916DF.6080200@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
 <1153933737.200164.160870@m73g2000cwd.googlegroups.com>
 <1154007393.940693.259680@i42g2000cwa.googlegroups.com>
 <mH3yg.16777$2u4.7977@trnddc06>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-David Beyer wrote:
> You need to compile with
> 
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_HIGHPTE=y
> CONFIG_X86_PAE=y
> CONFIG_HIGHIO=y
> CONFIG_X86_4G=y
> CONFIG_X86_SWITCH_PAGETABLES=y
> CONFIG_X86_4G_VM_LAYOUT=y
> CONFIG_X86_UACCESS_INDIRECT=y
> CONFIG_X86_HIGH_ENTRY=y
> 
> in your .config (for *86 machines) to get 4G of user and 4G of system space.
> I so or know how much sense this would make for a 4G of RAM machine. I never
> tried it when this machine had only 4G, but that is what is required to get
> all 4G in a single user process now that I have 8G.

Those options are not applicable on an x86-64 kernel.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

