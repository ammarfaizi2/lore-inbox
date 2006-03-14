Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWCNPHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWCNPHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCNPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:07:25 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:57170 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751186AbWCNPHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:07:25 -0500
Message-ID: <4416DBC2.8000103@cfl.rr.com>
Date: Tue, 14 Mar 2006 10:05:38 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Peter Hagervall <hager@cs.umu.se>
CC: CIJOML <cijoml@volny.cz>, linux-kernel@vger.kernel.org
Subject: Re: Dmesg is not showing whole boot list
References: <200603140901.27746.cijoml@volny.cz> <20060314083812.GA27338@brainysmurf.cs.umu.se>
In-Reply-To: <20060314083812.GA27338@brainysmurf.cs.umu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2006 15:09:30.0196 (UTC) FILETIME=[4B065940:01C64779]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14323.000
X-TM-AS-Result: No--10.817000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or look in your /var/log/kern.log file instead of asking dmesg.  dmesg 
just dumps the kernel ring buffer which is of finite size.  The entire 
contents should be logged to /var/log/kern.log.

Peter Hagervall wrote:
> On Tue, Mar 14, 2006 at 09:01:27AM +0100, CIJOML wrote:
>> Hello,
>>
>> maybe this si a wrong list to ask, bug after boot, dmesg shows that few lines 
>> at the beginning are missing.
>>
>> Is there any option I can increase to get full dmesg?
> 
> Try increasing CONFIG_LOG_BUF_SHIFT and recompile. That's likely the
> source of your problem.
> 
> 
> 
> 	Peter Hagervall
> 

