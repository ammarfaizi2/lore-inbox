Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWASTqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWASTqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWASTqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:46:01 -0500
Received: from cable-212.76.255.90.static.coditel.net ([212.76.255.90]:13964
	"EHLO jekyll.org") by vger.kernel.org with ESMTP id S1161361AbWASTqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:46:00 -0500
Message-ID: <43CFEC68.4070704@jekyll.org>
Date: Thu, 19 Jan 2006 20:45:44 +0100
From: Gilles May <gilles@jekyll.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP trouble
References: <43CAFF80.2020707@jekyll.org> <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com> <43CFD877.4090503@jekyll.org> <Pine.LNX.4.64.0601191132010.1579@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0601191132010.1579@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Thu, 19 Jan 2006, Gilles May wrote:
>
>  
>
>>Attached the bootlog with noapic parameter passed to the kernel. It still
>>freezes though. :(
>>What I do exactly to make it freeze is after boot:
>>
>>In one console I do a ping -f to a box on my local network using the e100
>>card. (integrated on the motherboard)
>>
>>In another console I copy a 2.5 GB file from my USB HDD to the IDE HDD in a
>>while loop (or do a readcd from USB DVD Writer to a file on IDE HDD)
>>    
>>
>
>Can you try it whilst copying from say SCSI disk to IDE disk?
>  
>
I don't think it has something to do with the USB card, nor the HDD oder 
the DVD writer connected to it..
Just to be sure I bought a new USB card with a different chip even, 
hangs with both controllers..
Besides it freezes aswell if I do the ping and IDE to IDE copies and 
listening music.. Looks like high
IO loads brings it down, no matter where it comes from..
The wierd part is that it's only with Linux SMP, not with UP, and no 
problems like that on WindowsXP SP2..

This starts giving me serious headaches.. ;)

Regards, Gilles May
