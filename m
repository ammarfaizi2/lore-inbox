Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270802AbTG0NWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTG0NWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:22:05 -0400
Received: from nic.bme.hu ([152.66.115.1]:14551 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S270802AbTG0NWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:22:02 -0400
Message-ID: <3F23D517.5020309@namesys.com>
Date: Sun, 27 Jul 2003 17:35:19 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@pp.inet.fi>
Cc: Yury Umanets <umka@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	 <1059062380.29238.260.camel@sonja>	 <16160.4704.102110.352311@laputa.namesys.com>	 <1059093594.29239.314.camel@sonja>	 <16161.10863.793737.229170@laputa.namesys.com>	 <1059142851.6962.18.camel@sonja>	 <1059143985.19594.3.camel@haron.namesys.com>	 <1059181687.10059.5.camel@sonja>	 <1059203990.21910.13.camel@haron.namesys.com> <1059239696.3036.4.camel@vaarlahti.uworld>
In-Reply-To: <1059239696.3036.4.camel@vaarlahti.uworld>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:

>On Sat, 2003-07-26 at 10:19, Yury Umanets wrote:
>
>  
>
>>>So basically we do have pretty powerful hardware with huge storage and
>>>memory and now need a FS which is fast and reliable even on flash
>>>memory. JFFS2 is nice but way too slow once one has bigger sizes.
>>>      
>>>
>>I think this is more then enough for running reiser4. Reiser4 is a linux
>>filesystem first of all, and linux is able to be ran on even worse
>>hardware then you have.
>>    
>>
>
>Most Linux filesystems can't be used properly with flash devices because
>of unability to handle write errors caused by flash wearing out. FS
>should mark the block as bad and relocate the data. Some devices report
>"read correctly, but had ECC" and when such happens data should also be
>relocated to not worn-out place and block marked as bad.
>
>
>  
>
I would be happy to accept a patch fixing that, or to fix it for a fee, 
or to fix it if we somehow get more funding from somewhere next year.;-)

-- 
Hans


