Return-Path: <linux-kernel-owner+w=401wt.eu-S932394AbWLLT1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWLLT1x (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWLLT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:27:53 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59098 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932394AbWLLT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:27:52 -0500
Message-ID: <457F02D3.5010004@cfl.rr.com>
Date: Tue, 12 Dec 2006 14:28:19 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrew Robinson <andrew.rw.robinson@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
In-Reply-To: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2006 19:28:04.0708 (UTC) FILETIME=[A52AC240:01C71E23]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14868.003
X-TM-AS-Result: No--11.376600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Robinson wrote:
> Now I am confused on what may be the cause of the corruption. Could it
> have been just a ReiserFS problem (I will be using Ext3 or JSF on my
> next rebuild I think after reading some reviews on the ReiserFS and
> this recent experience).

I have been running reiser on  my home machine and a server at work for 
a year now without incident.  There were some bugs a few years back but 
it seems to be in good working order these days.

> I'm not sure if it could be a SATA_NV driver problem, a hibernate
> problem, or a ReiserFS problem or a combination of the above. For
> hibernation, I had the resume2 kernel boot option set as /dev/sda1 (my
> swap partition). I do not have suspend2 installed though, I have been
> relying on its fallback settings to ususpend or sysfs (not sure which
> one is actually executed).

Sounds like your hibernation corrupted the disk, but without more 
specifics, this is just educated guesswork.


