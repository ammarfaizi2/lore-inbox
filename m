Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbTG0NP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270769AbTG0NP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:15:26 -0400
Received: from nic.bme.hu ([152.66.115.1]:16855 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S270767AbTG0NPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:15:25 -0400
Message-ID: <3F23D38B.3020309@namesys.com>
Date: Sun, 27 Jul 2003 17:28:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: Yury Umanets <umka@namesys.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	 <1059062380.29238.260.camel@sonja>	 <16160.4704.102110.352311@laputa.namesys.com>	 <1059093594.29239.314.camel@sonja>	 <16161.10863.793737.229170@laputa.namesys.com>	 <1059142851.6962.18.camel@sonja>	 <1059143985.19594.3.camel@haron.namesys.com>	 <1059181687.10059.5.camel@sonja>	 <1059203990.21910.13.camel@haron.namesys.com> <1059228808.10692.7.camel@sonja>
In-Reply-To: <1059228808.10692.7.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

>Am Sam, 2003-07-26 um 09.19 schrieb Yury Umanets:
>
>  
>
>>I think this is more then enough for running reiser4. Reiser4 is a linux
>>filesystem first of all, and linux is able to be ran on even worse
>>hardware then you have.
>>    
>>
>
>Linux is running just fine one the system, thanks. My question is
>whether reiserfs is suitable for flash devices. The chances to get some
>usable answers seem to be incredible low though...
>
>  
>
it is suitable for any flash device that has wear leveling built into 
the hardware (e.g. all compact flash cards), or for which a wear 
leveling block device driver is used (I don't know if one exists for Linux).

-- 
Hans


