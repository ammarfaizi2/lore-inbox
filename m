Return-Path: <linux-kernel-owner+w=401wt.eu-S1161116AbXAEPXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbXAEPXY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbXAEPXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:23:24 -0500
Received: from rtr.ca ([64.26.128.89]:2204 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161116AbXAEPXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:23:24 -0500
Message-ID: <459E6D67.4060307@rtr.ca>
Date: Fri, 05 Jan 2007 10:23:19 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ed Sweetman <safemode2@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
References: <459C5D6C.5010509@comcast.net> <459D1E55.60206@rtr.ca> <459D7AC8.1000907@comcast.net>
In-Reply-To: <459D7AC8.1000907@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Mark Lord wrote:
>> Ed Sweetman wrote:
>>> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in 
>>> libata land but SMART is no longer available on my hdds. 
>>
>> It's working for me with 2.6.20-rc3, ata_piix libata driver.
>>
> Well, not in the sata_nv libata driver. 

Exactly what "smartctl" command/parms are you using,
and exactly what output does it produce?

Hint:

smartctl -data -a  /dev/sda   ## ????
---------^^^^^-----------------------

