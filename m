Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbSJDWUO>; Fri, 4 Oct 2002 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbSJDWUO>; Fri, 4 Oct 2002 18:20:14 -0400
Received: from hokua.cfht.hawaii.edu ([128.171.80.51]:27876 "EHLO
	hokua.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S261892AbSJDWUK>; Fri, 4 Oct 2002 18:20:10 -0400
Message-ID: <3D9E148B.7050302@cfht.hawaii.edu>
Date: Fri, 04 Oct 2002 12:22:03 -1000
From: Kanoalani Withington <kanoa@cfht.hawaii.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alvin Oga <aoga@maggie.linux-consulting.com>
CC: Illtud Daniel <illtud.daniel@llgc.org.uk>,
       Effrem Norwood <enorwood@effrem.com>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, jbradford@dial.pipex.com,
       jakob@unthought.net, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup - mtx w/ tcl
References: <Pine.LNX.3.96.1021004144923.10481C-100000@Maggie.Linux-Consulting.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

Funny, when I searched for it on the web I didn't find anything. The 
original was written by Leonard Zubkoff and subsequently modified by 
Eric Lee Green. I never got it to work for me until around version 
1.2.15. I emailed Eric to see what's up with it but in the meantime I 
put my latest copy of it on my anonymous ftp server:

ftp.cfht.hawaii.edu:/pub/daprog/kanoa/mtx-1.2.16rel.tar.gz

Its got a GPL so that must be O.K.

It is great software. Basically it uses the scsi generic device to 
provide command line access to the device robotics so you can move 
tapes, use the export slots and barcode readers etc in a tape or optical 
jukebox.  It's a snap to then write archive and backup scripts that can 
pick and track tapes in the library.

When I first started writing scripts instead of buying $10k+ software 
packages I was using JBdriver, a commercial product that cost me nearly 
$2k (comparatively a good deal) which does the same thing. When they 
wanted another $1k to switch from a solaris box to a linux box I ditched 
it for mtx which works better and faster. It also installed in less than 
5min.

I wonder what happened to it?

-Kanoa

Alvin Oga wrote:

>
>hi ya kanoalani
>
>are ya willing to release that mtx code ??
>( well more like where can i find it )
>
>i'd like to add it to the collection
>	http://www.Linux-Backup.net/app.gwif.html
>	
>thanx
>alvin
>
>On Fri, 4 Oct 2002, Kanoalani Withington wrote:
>
>...
>
>>I agree it's a total racket. I've spent an appalling amount of money on 
>>this stuff over the years considering how simple it is. Last year I 
>>finally built mtx, the open source tape library driver, and wrote my own 
>>software in tcl scripts for a new archiving system. It really is that 
>>simple, I don't know how they can charge so much for thier software, 
>>especially when some it is junk to begin with.
>>
>>-Kanoa
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


