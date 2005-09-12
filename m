Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVILUJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVILUJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVILUJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:09:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:39046 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932191AbVILUJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:09:39 -0400
Message-ID: <4325E077.3000103@adaptec.com>
Date: Mon, 12 Sep 2005 16:09:27 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>
In-Reply-To: <20050912164548.GB11455@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 20:09:33.0461 (UTC) FILETIME=[E4365450:01C5B7D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 12:45, Patrick Mansfield wrote:
> On Mon, Sep 12, 2005 at 09:57:21AM -0500, James Bottomley wrote:
> 
> 
>>be free to increase it if necessary.  Note: you do actually need either
>>an array with more than two levels of nesting actually to need the
>>increase and no-one actually seems to have one of these yet.
> 
> 
> That is not correct, I posted before on this, the address method is in the
> high bits of the 8 byte LUN and tells how to "interpret" the LUN value.
> You can't convert from an int to 8 byte LUN (without any other
> information) and set these bits. See SAM-4 in (or near) section 4.9.7.
> 
> So some storage devices that want to use addressing methods other than 00b
> don't because we do not have 8 byte LUN support in linux, and then we have
> other problems because of this.

All true.

	Luben
