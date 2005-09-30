Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVI3WOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVI3WOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVI3WOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:14:16 -0400
Received: from magic.adaptec.com ([216.52.22.17]:56795 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932293AbVI3WOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:14:15 -0400
Message-ID: <433DB8AF.4090207@adaptec.com>
Date: Fri, 30 Sep 2005 18:14:07 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       willy@w.ods.org, patmans@us.ibm.com, ltuikov@yahoo.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com> <433D8D1F.1030005@adaptec.com> <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com>
In-Reply-To: <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 22:14:07.0966 (UTC) FILETIME=[46CCC7E0:01C5C60C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 17:31, Kyle Moffett wrote:
> Jeff Garzik et. al. seem to think that they are necessary, and I  

I've been contending this since before Jeff started work on
libata.  But none of the ideas: 64 bit LUN, HCIL removal, etc.,
were accepted with "submit a patch".

> So you're saying fixing the current SCSI subsystem once *now* costs  
> more than applying all *future* SCSI fixes to _two_ SCSI subsystems,  
> handling bug reports for _two_ SCSI subsystems, etc.

I'm saying that the current "old" one is already obsolete,
when all you have is a SAS chip on your mainboard.

All you need is a small, tiny, fast, slim SCSI Core.

>>>s/Politics.*//g;  I hate politics.  Keep it off this list.
>>
>>Me too, but we are idealists.  Politics is an integral part of life.
> 
> 
> Politics are not an integral part of productive technical  
> discussions, though.  If you discuss technical topics and provide  
> realistic technical descriptions, examples, reasons, code, etc, then  
> politics tends not to matter in the discussion, and we're all happier  
> people.

Yes, please re-read this thread, and open and read all the
references I've included to SAM, SPC, SAS and SAT of T10.org.

Politics: "Nah, whatever you say, specs are *crap* and we'll
do it our way.  We are not interested in your way, even if it
were better.  Oh, and BTW, REQUEST SENSE clears ACA and LUN
is a u64."

See?
	Luben
