Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSAPVRc>; Wed, 16 Jan 2002 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSAPVP6>; Wed, 16 Jan 2002 16:15:58 -0500
Received: from jester.ti.com ([192.94.94.1]:48619 "EHLO jester.ti.com")
	by vger.kernel.org with ESMTP id <S287627AbSAPVPe>;
	Wed, 16 Jan 2002 16:15:34 -0500
Message-ID: <3C45ED3A.7060403@ti.com>
Date: Wed, 16 Jan 2002 22:14:34 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: aa works for me..rrmap didn't
In-Reply-To: <Pine.LNX.4.33L.0201161904270.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Wed, 16 Jan 2002, christian e wrote:
> 
> 
>>An update yet again for those who may care.I tried both aa patch and
>>rrmap patch and the aa patch works fine.I havent got any swap issues
>>with that patch.The rrmap seemed ok in the beginning but then all hell
>>broke loose and it swapped like map and my apps took minutes to start.
>>Sorry for the lack of details I haven't got time for further debugging :-(
>>
> 
> It would be nice if you could at least tell us what workload
> you're running, this way there really isn't any way for me to
> find out what to search for ;)


Sure..No problem..Currently running:

* Mozilla mail

* mozilla browser

* 7-8 xterms

* xmms playing loud music :-)

* vmware running my windows XP pro,256 megs of mem reserved for the 
virtual machine..inside XP two instances of Internet explorer,ICQ,MS 
Access,MS Excel

* vncviewer to a windows box


I think that's about it ;-)

And I did the echo 500 > /proc/sys/vm/vm_mapped_ratio with the aa patch..

At first the rrmap was just as good,but apparently it decided to swap 
out my vmware so all of a sudden it seemed to be running off the 
harddrive only and just changing desktops in X took ages...swap was up 
to 130 MB before I decided to reboot using the aa patch.

Now swap is at 300k and seems stable so far..It will increase I'm sure 
(did the last time) but not as much as the rrmap..Still I'd like to do 
without swap altogether but I can't as vmware won't run without it :-(


best regards

Christian

