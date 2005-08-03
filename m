Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVHCLIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVHCLIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVHCLIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:08:44 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:27624 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262220AbVHCLIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:08:43 -0400
Message-ID: <42F0A5B8.6060300@tomt.net>
Date: Wed, 03 Aug 2005 13:08:40 +0200
From: =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> Jens Axboe wrote:
> 
>>> If I am reading the specs correctly, that'd mean the ahci driver is 
>>> wrong in setting the SActive bit.
>>
>>
>> I completely agree, that was my reading of the spec as well and hence my
>> original posts about this in the NCQ thread.
> 
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?

I have, Asus P5LD2 i945P, ICH7R AHCI controller, Hitachi Deskstar T7K250 
250GB "SATA2" drives. Kernel 2.6.12.x
