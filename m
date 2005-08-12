Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVHLCrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVHLCrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHLCrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:47:55 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:29253 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750755AbVHLCry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:47:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C1gJHZH5lfeVYJgZgHmh55aP56JlYuTTpytRM1l/kLbOjb9cm5CojRNzHtTyBrHHNp1pRMIvtH4J+AVWkVzdOF3tR8qmBn5PvZ3qfUeTXq9+BSskceQCv6csMjVnamOXoDa0hY6DoQ1WjEWapGzXD+iBAysA60v1lpVjk0JVVFE=
Message-ID: <42FC0DD4.9060905@gmail.com>
Date: Fri, 12 Aug 2005 11:47:48 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Jackman <sjackman@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
References: <7f45d939050809163136a234a@mail.gmail.com>
In-Reply-To: <7f45d939050809163136a234a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Jackman wrote:
> I added a PCI SATA controller to my computer. Immediately after grub
> loads the kernel there is a consistent ten minute delay before the
> kernel displays its first message. I tested Linux 2.6.8 and 2.6.11
> both from Debian, and 2.6.11 from Knoppix, all of which experience the
> same delay.
> 
> The SATA controller is connected to two 200 GB Seagate SATA
> ST3200826AS drives. I managed to install Debian on the system, though
> the install was perilous, and once booted the system runs wonderfully!
> Any suggestions on how I can trouble shoot the ten minute boot delay?
> I don't reboot frequently, but it is irksome.
> 
> What's the appropriate mailing list for SATA questions, perhaps
> linux-ide or linux-scsi?
> 
> Please cc me in your reply. Thanks!
> Shaun
>


  Hi, Shaun Jackman.

  The list would be linux-ide but it doesn't really seem like a SATA 
problem.

  * What do you mean by the `first' message?  ie. What's the first line 
you read?
  * Is it really ten minutes?

-- 
tejun
