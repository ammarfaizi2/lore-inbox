Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUJIXz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUJIXz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUJIXz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:55:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267656AbUJIXyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:54:35 -0400
Message-ID: <41687A2C.9000406@pobox.com>
Date: Sat, 09 Oct 2004 19:54:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
References: <200410092337.36488.bzolnier@elka.pw.edu.pl>	 <20041009230300.75239.qmail@web13724.mail.yahoo.com> <58cb370e04100916441c1b74d@mail.gmail.com>
In-Reply-To: <58cb370e04100916441c1b74d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sat, 9 Oct 2004 16:03:00 -0700 (PDT), Martins Krikis
> <mkrikis@yahoo.com> wrote:
> 
>>--- Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> wrote:
>>
>>
>>>I may sound like an ignorant but...
>>>
>>>Why can't device mapper be merged into 2.4 instead?
>>
>>"Instead" is the key word here... That would mean that
>>Boji's and my work has been largely in vain and that the
>>driver that to my best knowledge currently provides the
>>simplest (from a user's point of view) cooperation with
>>Intel RAID OROM and the most comlete feature-set regarding
>>Intel RAID metadata interpretation and updates would not
>>make it to the kernel. I have nothing against device mapper
>>being merged into 2.4 but I don't consider that a fair
>>reason for not considering iswraid.
> 
> 
> Well, in some way this speaks against merging iswraid in 2.4.
> If it provides "the most comlete feature-set regarding Intel RAID
> metadata interpretation and updates" then merging it would
> create regression when compared to 2.6, wouldn't it?


When the other RAIDs are ataraid in 2.4 and DM in 2.6, doing iswraid DM 
in 2.4 violates the Principle of Least Surprise ;-)

	Jeff


