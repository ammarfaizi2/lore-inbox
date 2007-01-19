Return-Path: <linux-kernel-owner+w=401wt.eu-S932772AbXASAMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbXASAMz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbXASAMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:12:55 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8580 "EHLO
	pd5mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772AbXASAMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:12:55 -0500
Date: Thu, 18 Jan 2007 18:12:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: EDAC chipkill messages
In-reply-to: <fa.CZkzgccjpiJW6cRrbtRvg/+4HMg@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Orion Poplawski <orion@cora.nwra.com>
Message-id: <45B00CD7.8050802@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.CZkzgccjpiJW6cRrbtRvg/+4HMg@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orion Poplawski wrote:
> Can someone please explain to me what these mean?
> 
> EDAC k8 MC1: general bus error: participating processor(local node 
> origin), time-out(no timeout) memory transaction type(generic read), mem 
> or i/o(mem access), cache level(generic)
> EDAC MC1: CE page 0xfbf6f, offset 0x4d0, grain 8, syndrome 0xc8f4, row 
> 1, channel 0, label "": k8_edac
> EDAC MC1: CE - no information available: k8_edac Error Overflow set
> EDAC k8 MC1: extended error code: ECC chipkill x4 error
> 
> Thanks!
> 

Sounds like you're having some memory ECC errors.. some Memtest86, etc. 
runs may be in order. You may be able to figure out from this info what 
DIMM is having the problem.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

