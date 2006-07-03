Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWGCVRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWGCVRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGCVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:17:40 -0400
Received: from main.gmane.org ([80.91.229.2]:28331 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932131AbWGCVRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:17:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Huge problem with XFS/iCH7R
Date: Mon, 03 Jul 2006 17:20:11 -0400
Message-ID: <44A98A0B.8080203@tmr.com>
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de> <20060703163216.B1474487@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
In-Reply-To: <20060703163216.B1474487@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Sun, Jul 02, 2006 at 09:51:45PM +0200, Carsten Otto wrote:
>> Hi there!
>>
>> (System specs below)
>>
>> Short summary:
>> System (with software raid 5, XFS, four disks connected to AHCI
>> controller) crashes very often and loses data.
>>
>> My system crashes every few days, at the moment daily. The message shown
>> is (the drive changes about every time, I do not see a pattern here):
>> ---
>> ata4: handling error/timeout
>> ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
>> ata4: status=0x50 { DriveReady SeekComplete }
>> sdd: Current: sense key=0x0
>> 	ASC=0x0 ASCQ=0x0
>> Info fid=0x0
> 
> FWIW, the above look like hardware/driver problems.

If the problem doesn't occur before 2.6.16, that makes a hardware 
problem less likely. It's not impossible that some buggy feature is now 
used, but lower probability than the kernel change being the culprit. 
The bug fix you mention may solve the whole thing, or make it easier to 
debug.

General comment: if a kernel version made my system crash once a day I 
sure wouldn't be using it. New features are neat, but I wouldn't put up 
with that if it made my cat pee holy water.

I would test proposed fixes, of course, but only until I got more info 
for developers.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

