Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270762AbTG0MqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTG0MqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:46:23 -0400
Received: from nic.bme.hu ([152.66.115.1]:33752 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S270762AbTG0MqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:46:22 -0400
Message-ID: <3F23CCBC.9070600@namesys.com>
Date: Sun, 27 Jul 2003 16:59:40 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	 <1059062380.29238.260.camel@sonja>	 <16160.4704.102110.352311@laputa.namesys.com>	 <1059093594.29239.314.camel@sonja>	 <16161.10863.793737.229170@laputa.namesys.com> <1059142851.6962.18.camel@sonja>
In-Reply-To: <1059142851.6962.18.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

>Am Fre, 2003-07-25 um 15.02 schrieb Nikita Danilov:
>
>  
>
>>No special measures are taken to level block allocation. Wandered blocks
>>are allocated to improve packing i.e., place blocks of the same file
>>close to each other. Actually, it tries to place tree nodes in the
>>parent-first order.
>>    
>>
>
>So the new blocks are created as close as possible to the old blocks
>instead of say spreading them as far as possible. This is pretty bad for
>usage in the embedded world but I guess this is not the market you're
>aiming at. :(
>
>  
>
I thought that close was fine, it was putting it in the same block that 
was the problem?

Again, I think this is best solved in the device layer.

-- 
Hans


