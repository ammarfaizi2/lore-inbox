Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWFFXiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWFFXiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWFFXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:38:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37857 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751360AbWFFXiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:38:54 -0400
Message-ID: <44861204.5030606@zytor.com>
Date: Tue, 06 Jun 2006 16:38:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       iss_storagedev@hp.com, Mike Miller <mike.miller@hp.com>
Subject: Re: kinit problem with cciss root device
References: <200606061640.48644.bjorn.helgaas@hp.com> <44860ED7.10608@zytor.com>
In-Reply-To: <44860ED7.10608@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Bjorn Helgaas wrote:
>>
>> So you might consider something like the "drain output" hunk below,
>> which allowed all the useful messages to get out.
>>
> 
> Hm.  That's rather ugly.  Anyone knows if TCFLSB works on /dev/console?
> 

That should of course have been TCSBRK(1), as in tcdrain().

	-hpa
