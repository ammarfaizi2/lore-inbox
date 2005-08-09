Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVHIIQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVHIIQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 04:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHIIQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 04:16:56 -0400
Received: from 203-217-29-35.perm.iinet.net.au ([203.217.29.35]:14275 "EHLO
	anu.rimspace.net") by vger.kernel.org with ESMTP id S932456AbVHIIQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 04:16:56 -0400
From: Daniel Pittman <daniel@rimspace.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AHA-2940U2W "Data Parity Error Dectected" messages
In-Reply-To: <1123572475.27813.2.camel@mindpipe> (Lee Revell's message of
	"Tue, 09 Aug 2005 03:27:54 -0400")
References: <878xzbr2zw.fsf@rimspace.net> <1123572475.27813.2.camel@mindpipe>
Date: Tue, 09 Aug 2005 18:16:46 +1000
Message-ID: <871x53r0cx.fsf@rimspace.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.5-b21 (corn, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:
> On Tue, 2005-08-09 at 17:19 +1000, Daniel Pittman wrote:
>> I recently installed a SCSI tape drive and Adaptec AHA-2940U2W SCSI
>> controller into my server to run backups.
>> 
>> Since then, the driver issues these warnings on a semi-regular basis
>> while the drive is busy:
>> 
>> Aug  9 17:00:26 anu kernel: scsi0: Data Parity Error Detected during address or write data phase
>> Aug  9 17:00:26 anu kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
>
> Make sure the hardware is all installed correctly.  Check that the card
> is fully seated, or try it in another PCI slot.  

Thanks.  I will take the server down shortly and give that a shot.

> Also check your cabling and termination.

Could SCSI cabling and/or termination cause the card to report *PCI*
errors, or am I misunderstanding these messages?

I guess that the fact that the "PCI" bit kept showing up in them is
what confuses me.  I didn't except a SCSI card to report PCI bus issues
through the Linux driver, and since it claimed to be a victim, not a
cause, I didn't know quite how to trace the problem down...

Thanks,
      Daniel
