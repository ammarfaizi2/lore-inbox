Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVJCOFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVJCOFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJCOFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:05:42 -0400
Received: from magic.adaptec.com ([216.52.22.17]:6078 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932237AbVJCOFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:05:41 -0400
Message-ID: <43413A89.60505@adaptec.com>
Date: Mon, 03 Oct 2005 10:04:57 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg Freemyer <greg.freemyer@gmail.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>	 <433D8542.1010601@adaptec.com>	 <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com>	 <433D8D1F.1030005@adaptec.com>	 <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com> <87f94c370509301510nba59ac2m59f507f70de6e46b@mail.gmail.com> <433DD020.8000906@pobox.com>
In-Reply-To: <433DD020.8000906@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 14:04:58.0220 (UTC) FILETIME=[703A32C0:01C5C823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 19:54, Jeff Garzik wrote:
> Greg Freemyer wrote:
> 
>>Luben has more than once called for adding a small number of
>>additional calls to the existing SCSI core.  These calls would
>>implement the new (reduced) functionallity.  The old calls would
>>continue to support the full SPI functionallity.  No existing  LLDD
>>would need modification.
> 
> 
> IOW, what Luben wants is:
> 
> 	if (Luben)
> 		do this
> 	else
> 		do current stuff
> 
> If this is the case, why bother touching drivers/scsi/* at all?

In order to have a new better, faster, slimmer SCSI Core.

	Luben
