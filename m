Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285227AbRLFVpp>; Thu, 6 Dec 2001 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285235AbRLFVpf>; Thu, 6 Dec 2001 16:45:35 -0500
Received: from ppp488-cwdsl.fr.cw.net ([62.210.101.233]:53258 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S285227AbRLFVp3>; Thu, 6 Dec 2001 16:45:29 -0500
Message-ID: <3C0FE745.7090903@paulbristow.net>
Date: Thu, 06 Dec 2001 22:46:45 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: joeja@mindspring.com, linux-kernel@vger.kernel.org
CC: Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.x 2.5.x wishlist
In-Reply-To: <Springmail.105.1007672585.0.54174000@www.springmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:

> I tried the patch on your site against 2.4.14, it helped, system still hung... 


Damn.  Lost interrupt is outside my code.  This lives in the ide driver 
proper and is probably relative toi the via82cxxx specific controller 
code that is deep voodoo from Andre.  I guess Andre/Jens have not found 
all the *funnies* in the buggy chipset.


> hdd lost interrupt
> 
> is there buffereing done in data transfers to disks?  


Yes, but at the FS level, not in clever driver level stuff.


> I.E. if I cp to a drive is the data transfered right away or is there a delay?
> 
> J
> 
> 
>>I have a patch out, and am trying to convince Marcelo to include it.  I 
>>*DO* know about this as I get lots of the mail complaining about it.  > If 
>>you are suffering, please try with the patch
>>
> 


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

