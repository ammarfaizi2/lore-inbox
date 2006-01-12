Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWALRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWALRWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWALRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:22:37 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:36023 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932315AbWALRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:22:36 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Orion Poplawski'" <orion@cora.nwra.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Help with machine check exception
Date: Thu, 12 Jan 2006 11:32:33 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYXlT5VKYSi6+oQSIGXO+GLNhjx1AACHJiQ
In-Reply-To: <dq606p$776$1@sea.gmane.org>
Message-ID: <EXCHG2003lbcrYP0QzB00000be1@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 12 Jan 2006 17:16:09.0431 (UTC) FILETIME=[E152D670:01C6179B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Orion Poplawski
> Sent: Thursday, January 12, 2006 10:30 AM
> To: linux-kernel@vger.kernel.org
> Subject: Help with machine check exception
> 
> Can someone help determine the problem here?  Does it 
> definitely point to a bad CPU, or possibly a bad motherboard?
> 
> Thanks!
> 
> CPU 0: Machine Check Exception:                4 Bank 4: 
> b200000000070f0f
> TSC 184fcd0553e4
> Kernel panic - not syncing: Machine check
> 

If this is an Opteron, CPU or Memory, a dimm failing in the
correct manner will cause it, and I have seen a CPU cause it,
I don't know that I have seen a MB cause it, and we have fixed
a fair number of these errors.   If it is memory, it can be any
of the dimms on that cpu.

I have seen this error kill a machine on boot up, but it looks
more like something was cleared improperly, and may only affect
much older versions of 2.6, in this case it is not broken hardware,
and rebooting will cause it to not be duplicatable.

                       Roger

