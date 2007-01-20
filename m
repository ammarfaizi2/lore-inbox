Return-Path: <linux-kernel-owner+w=401wt.eu-S932883AbXATDPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbXATDPq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbXATDPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:15:46 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31884 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932883AbXATDPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:15:45 -0500
Date: Fri, 19 Jan 2007 21:15:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Missing dmesg parameters in 2.6.19.2
In-reply-to: <fa.fNZG37ToxSA055/pURYuraLOnPA@ifi.uio.no>
To: Sunil Naidu <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <45B1895F.1090206@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.fNZG37ToxSA055/pURYuraLOnPA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil Naidu wrote:
> Hello All,
> 
> Atlast I have succeeded in booting 2.6.19.2 on mutiple x86 machines. I
> did observe a strange dmesg parameter behavior in this case:-
> 
> 
> 1) Compiling with SMP as Generic (CONFIG_X86_PC is not set, CONFIG_M686=y)
> 
> ........
> ........
> Using x86 segment limits to approximate NX protection
> ........
> ........
> Using APIC driver default
> ........
> ........
> 
> 2) Compiling with SMP as Processor specific (CONFIG_X86_PC=y,
> CONFIG_MPENTIUM4=y)
> 
> I do not find the above mentioned parameters in this case.

I don't think the "segment limits" message shows up in stock kernels, 
are you sure that was from 2.6.19.2? That sounds like a Fedora kernel 
with Exec Shield.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

