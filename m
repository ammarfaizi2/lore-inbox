Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVJCPIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVJCPIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVJCPIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:08:44 -0400
Received: from magic.adaptec.com ([216.52.22.17]:25044 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751037AbVJCPIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:08:43 -0400
Message-ID: <43414975.5090708@adaptec.com>
Date: Mon, 03 Oct 2005 11:08:37 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Greg Freemyer <greg.freemyer@gmail.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, patmans@us.ibm.com,
       ltuikov@yahoo.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com> <433D8D1F.1030005@adaptec.com> <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com> <87f94c370509301510nba59ac2m59f507f70de6e46b@mail.gmail.com> <433DD020.8000906@pobox.com> <20051001045812.GF18716@alpha.home.local>
In-Reply-To: <20051001045812.GF18716@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 15:08:37.0928 (UTC) FILETIME=[54F36280:01C5C82C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/05 00:58, Willy Tarreau wrote:
> On Fri, Sep 30, 2005 at 07:54:08PM -0400, Jeff Garzik wrote:
> 
>>Greg Freemyer wrote:
>>
>>>Luben has more than once called for adding a small number of
>>>additional calls to the existing SCSI core.  These calls would
>>>implement the new (reduced) functionallity.  The old calls would
>>>continue to support the full SPI functionallity.  No existing  LLDD
>>>would need modification.
>>
>>IOW, what Luben wants is:
>>
>>	if (Luben)
>>		do this
>>	else
>>		do current stuff
>>
>>If this is the case, why bother touching drivers/scsi/* at all?
> 
> 
> that's the reason why I proposed that this moved to drivers/sas/* or
> somewhere else so that there is no maintaining conflict.

Yes, it has been moved already there.
http://linux.adaptec.com/sas/

	Luben
