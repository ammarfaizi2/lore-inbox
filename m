Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWACRoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWACRoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWACRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:44:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64656 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932385AbWACRoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:44:04 -0500
Message-ID: <43BAB7D4.4050204@pobox.com>
Date: Tue, 03 Jan 2006 12:43:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
References: <20060103164319.GA402@havoc.gtf.org>	 <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com> <1136309555.22598.10.camel@localhost.localdomain>
In-Reply-To: <1136309555.22598.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > On Maw, 2006-01-03 at 17:51 +0100,
	Bartlomiej Zolnierkiewicz wrote: > >>>+ * with SITRE and the 0x44
	timing register). See pata_oldpiix and pata_mpiix >>>+ * for the early
	chip drivers. >> >>pata_oldpiix and pata_mpiix are not in the mainline
	> > > They are probably ready for mainline and since Linux currently
	has no > support for either it might be nice to get them in. Anything
	specific > they need polishing for Jeff ? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-01-03 at 17:51 +0100, Bartlomiej Zolnierkiewicz wrote:
> 
>>>+ * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
>>>+ * for the early chip drivers.
>>
>>pata_oldpiix and pata_mpiix are not in the mainline
> 
> 
> They are probably ready for mainline and since Linux currently has no
> support for either it might be nice to get them in. Anything specific
> they need polishing for Jeff ?

Not really.  If there's no support in mainline, I'm ok with pushing them 
upstream...  provided that they have been tested and verified to work on 
at least one machine?  :)

	Jeff



