Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWFHT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWFHT4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWFHT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:56:18 -0400
Received: from smtpout.mac.com ([17.250.248.177]:31950 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964945AbWFHT4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:56:17 -0400
In-Reply-To: <4488368B.5070103@rtr.ca>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com> <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com> <4488368B.5070103@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7B0A3459-7DED-403F-9728-3AD03A2CD4B0@mac.com>
Cc: Rahul Karnik <rahul@genebrew.com>, Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: booting without initrd
Date: Thu, 8 Jun 2006 14:56:06 -0500
To: Mark Lord <lkml@rtr.ca>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 8, 2006, at 9:39 AM, Mark Lord wrote:

> Rahul Karnik wrote:
>>
>> AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
>> grub.conf and therefore needs the initrd in order to work correctly.
>> If you do not want an initrd, then change this to
>> "root=/dev/<your_disk>" in grub.conf. Note that the reason Fedora  
>> uses
>> the LABEL is so you can move disks around in your system without a  
>> problem
>
> Heh.. except for people like me, who regularly swap disks around
> to boot from different distros, in which case the LABEL=/ continuously
> causes nothing but grief until I remember to edit it away.

You would like labels a lot better if you took charge and forced the  
labels to be something like "FC4-root", "SLES9-root" etc. rather than  
the default "/".

-- 
Mark Rustad, MRustad@mac.com

