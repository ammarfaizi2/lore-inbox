Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWGZWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWGZWNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWGZWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:13:48 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:64658 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1161004AbWGZWNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:13:48 -0400
Message-ID: <44C7F135.7000509@wolfmountaingroup.com>
Date: Wed, 26 Jul 2006 16:48:21 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adam radford <aradford@gmail.com>
CC: dean gaudet <dean@arctic.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
References: <20060710141315.GA5753@fi.muni.cz>	 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>	 <1153946249.13509.29.camel@localhost.localdomain>	 <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org> <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
In-Reply-To: <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam radford wrote:

> On 7/26/06, dean gaudet <dean@arctic.org> wrote:
>
>>
>> unfortunately when i did the experiment i neglected to perform
>> simultaneous tests on more than one 3ware unit on the same 
>> controller.  i
>> got great results from a raid1 or from a raid10 (even a raid5)... but
>> never i only tested one unit at a time.
>>
>
> Did you try setting /sys/class/scsi_host/hostX/cmd_per_lun to 256 / 
> num_units ?
>
> -Adam
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Adam,

Isn't it set to this by default or is the default 128?

Jeff
