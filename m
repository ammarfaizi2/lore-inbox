Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUCQUDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCQUC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:02:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47034 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262027AbUCQUCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:02:53 -0500
Message-ID: <4058AEDE.10305@pobox.com>
Date: Wed, 17 Mar 2004 15:02:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <20040317193206.A17987@infradead.org>
In-Reply-To: <20040317193206.A17987@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Mar 17, 2004 at 02:18:25PM -0500, Jeff Garzik wrote:
> 
>>>	o Allow fully pluggable meta-data modules
>>
>>yep, needed
> 
> 
> Well, this is pretty much the EVMS route we all heavily argued against.
> Most of the metadata shouldn't be visible in the kernel at all.

_some_ metadata is required at runtime, and must be in the kernel.  I 
agree that a lot of configuration doesn't necessarily need to be in the 
kernel.  But stuff like bad sector and event logs, and other bits are 
still needed at runtime.


>>>	o Improve the ability of MD to auto-configure arrays.
>>
>>hmmmm.  Maybe in my language this means "improve ability for low-level 
>>drivers to communicate RAID support to upper layers"?
> 
> 
> I think he's talking about the deprecated raid autorun feature.  Again
> something that is completely misplaced in the kernel.  (ågain EVMS light)

Indeed, but I'll let him and the code illuminate the meaning :)

	Jeff



