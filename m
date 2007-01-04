Return-Path: <linux-kernel-owner+w=401wt.eu-S965100AbXADWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbXADWSO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbXADWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:18:14 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:59727 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965100AbXADWSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:18:13 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 17:18:13 EST
Message-ID: <459D7BC9.1050108@comcast.net>
Date: Thu, 04 Jan 2007 17:12:25 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
References: <459C5D6C.5010509@comcast.net> <200701040349.16650.s0348365@sms.ed.ac.uk>
In-Reply-To: <200701040349.16650.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 04 January 2007 01:50, Ed Sweetman wrote:
>   
>> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in
>> libata land but SMART is no longer available on my hdds.   I'm assuming
>> this is not the intended behavior.
>>
>> In case this is chipset specific, IDE interface: nVidia Corporation
>> CK804 Serial ATA Controller (rev f3)
>>
>> I'm using Libata nvidia driver, the drives happen to be sata drives, but
>> even the pata ones no longer report having SMART.
>>     
>
> What program are you trying to use here? As I reported around -rc1 time, 
> hddtemp is broken by 2.6.20-rc but Jens posted a patch to fix it.
>
>   

I must have missed that blurb.   hddtemp is indeed the program I was 
looking at.  And it does seem that it is the only one broken.  Just 
re-installed the other smartctl tools and they do work.  Thanks.
