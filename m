Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSLaUaY>; Tue, 31 Dec 2002 15:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSLaUaY>; Tue, 31 Dec 2002 15:30:24 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:54790
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261600AbSLaUaX>; Tue, 31 Dec 2002 15:30:23 -0500
Message-ID: <3E120054.2070405@rackable.com>
Date: Tue, 31 Dec 2002 12:38:44 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 responsiveness
References: <UTC200212311911.gBVJBxe03777.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 20:38:44.0092 (UTC) FILETIME=[9C5DEBC0:01C2B10C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>Fetched Solaris 9 CDROM images yesterday, unpacked, copied, etc.
>Manipulating these 600+ MB files totally kills the machine
>(with 256 MB memory). Keystrokes are reacted to after half a minute.
>It is impossible to use the mouse since the kernel is too slow
>to accept mouse packets within its self-imposed timeout, so that
>the logs are full of
>psmouse.c: Lost synchronization, throwing 1 bytes away.
>psmouse.c: Lost synchronization, throwing 3 bytes away.
>psmouse.c: Lost synchronization, throwing 1 bytes away.
>psmouse.c: Lost synchronization, throwing 3 bytes away.
>The clock lost somewhat over 10 minutes.
>
>This is really primitive behaviour.
>
>Andries
>
>
>[everything vanilla - no settings changed, no hdparm used]
>  
>

  Was the cdrom in dma mode?  Does ""hdparm -d 1 /dev/cdrom"  work?  

  How much swap do you have?

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



