Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLVOGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 09:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTLVOGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 09:06:45 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:6928 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264314AbTLVOGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 09:06:44 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: cleanerx@au.hadiko.de
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
Date: Tue, 23 Dec 2003 00:06:25 +1000
User-Agent: KMail/1.5.1
References: <200312221451.06331.ross@datscreative.com.au>
In-Reply-To: <200312221451.06331.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312222341.32367.ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If the noapic or acpi=off stabilizes it for you and you want to run with apic
>> and io-apic then my patches may help.
>> 
>> You can find them in this thread
>> 
>> Updated Lockup Patches, 2.4.22 - 23 Nforce2, apic timer ack delay, ioapic edge
>>  for NMI debug
>> 
>> If unsubscribed you can find it here
>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4673.html
>> or here
>> http://lkml.org/lkml/2003/12/21/156


>I played a bit around with apic off and on and still it had no effect. My 
> board keeps crashing. Seems not to be related to apic. 

>Jens 

Might be a mandrake source thing, not liking nforce2 perhaps?

If you don't mind a bit of work, you could download current standard 2.4.23
kern source, add my patches, compile with acpi and uniprocessor ioapic,
Athlon etc. use the onboard nic, and try it with apic_tack=1 kernel arg.

Regards
Ross.
