Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSEWSHE>; Thu, 23 May 2002 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSEWSHD>; Thu, 23 May 2002 14:07:03 -0400
Received: from freeside.toyota.com ([63.87.74.7]:44552 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S316973AbSEWSHD>; Thu, 23 May 2002 14:07:03 -0400
Message-ID: <3CED2FB2.9080804@lexus.com>
Date: Thu, 23 May 2002 11:06:42 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020522
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: ip alias and default outgoing interface
In-Reply-To: <Pine.LNX.3.96.1020523101028.11249B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing also - this is with 2.4.19-pre3aa2 -
and I know I saw it with earlier 2.4 kernels.
I just checked and I'm seeing it on my
workstation here, running 2.4.19-pre8-ac5.

I'd have a working ethernet interface, with
a functional default route - now if I bring up
a virtual address on the same ethernet
device, all outgoing traffic from that point
on emanates from the IP of the new virtual
interface - which created some problems
if there are firewall rules based on IP addr.

I know there is some way to fix this with the
advanced routing features, but I hadn't time
to look into it until now - and the above does
seem to be the default behavior.

Joe

Bill Davidsen wrote:

>On Wed, 22 May 2002, Mohammad A. Haque wrote:
>
>  
>
>>I've got a setup where I have one ethernet card and multiple ips 
>>assigned using ip alias.
>>
>>i've noticed that sometimes out going traffic goes out using the ip of 
>>the last interface I brought up.
>>
>>Is this supposed to happen? How do I make it so that the default gw 
>>interface is used?
>>    
>>
>
>Time to tell us which kernel you run. I haven't seen this with 2.4.recent,
>but most of the connections are either incoming or explicitly SNET'd.
>
>  
>



