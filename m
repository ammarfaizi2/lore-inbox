Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTLVEw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 23:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVEw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 23:52:58 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:34058 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S262328AbTLVEwu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 23:52:50 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: cleanerx@au.hadiko.de
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
Date: Mon, 22 Dec 2003 14:51:06 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312221451.06331.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Jens Kübler wrote: 
 
>> Hi 
> > 
> > My computer will freeze if I produce heavy network traffic. The crashes 
> > happen after an arbitrary time and seem not to be related to hardware 
> > defects. I tried the onboard nic and the rtl8139 which worked fine for me 
> > with my old mainboard. I've copied the same file with windowsXP and tried 
> > some other heavy network traffic just to see wheater it might be an 
> > hardware error but the system was stable. After I have started to import 
> > my home directory via NFS the crashes became more often. I will crash my 
> > system if I copy a big file via SMB. 
> > I had the problem with Mandrake 9.1 and now with 9.2 and even compiled my 
> > own kernel (mandrake source) with no effect. 
> > 
> > Any suggestions? 
> > 

>Boot with noapic or acpi=off 
> --
>Regards
>Thomas

If the noapic or acpi=off stabilizes it for you and you want to run with apic
and io-apic then my patches may help.

You can find them in this thread

Updated Lockup Patches, 2.4.22 - 23 Nforce2, apic timer ack delay, ioapic edge
 for NMI debug

If unsubscribed you can find it here
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4673.html
or here
http://lkml.org/lkml/2003/12/21/156

Regards
Ross Dickson

