Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUASSLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUASSJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:09:03 -0500
Received: from hermes.domdv.de ([193.102.202.1]:11784 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S262129AbUASSIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:08:35 -0500
Message-ID: <400C1D16.5010008@domdv.de>
Date: Mon, 19 Jan 2004 19:08:22 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
CC: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: DMA timeout error and then kernel halted
References: <1074533362.7913.14.camel@narsil>
In-Reply-To: <1074533362.7913.14.camel@narsil>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Mynarik wrote:
> Hi,
> 
> I have DMA problems with HPT366 on BP6 (newest BIOS version RU incl.
> 1.28 BIOS for HPT366) and Seagate's 80 GB disk (please see exact model
> numbers in attached dmesg).
> 
> It's reproducible (with or without SMP, various kernel versions,
> overclocking or not, ACPI on and off) on 2.4.22 and 2.6.0 (test9, test11
> and vanilla) and 2.6.1-rc3. On 2.4 kernel it doesn't halt kernel.
> 

I do have similar problems with a HPT302 and WD2500JB disks on a Tyan 
S2885 (Dual Opteron 246). What does help me is to disable the IO-APICs 
at boot time using "noapic".

Thus I don't believe this to be a disk/mobo problem but probably a 
driver problem.
-- 
Andreas Steinmetz

