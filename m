Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315926AbSETMTB>; Mon, 20 May 2002 08:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315927AbSETMTA>; Mon, 20 May 2002 08:19:00 -0400
Received: from employees.nextframe.net ([212.169.100.200]:16123 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S315926AbSETMS7>; Mon, 20 May 2002 08:18:59 -0400
Date: Mon, 20 May 2002 14:23:25 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Jens Christian Skibakk <jenscski@sylfest.hiof.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
Message-ID: <20020520142325.B143@sexything>
Reply-To: morten.helgesen@nextframe.net
In-Reply-To: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 02:07:34PM +0200, Jens Christian Skibakk wrote:
> 
> When I unpack a tar-archive containing many files (about halv a million)
> this errors occures in the dmesg output:
> EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
> 
> and the program complins about: No space left on device, but df -h shows
> that there is over 1G free on the hd.

Can you please paste the output from 'df -h' and 'df -i' ? 

> 
> After this error occurs the hd contains errors and need to be checked.
> 
> The filesystem on the hd is ext3.
> 
> I have tested this with to kernel-verions, on both 2.4.18 and
> 2.4.19-pre8-ac3 the error occurs.
> 
> 
> Else my system is :
> glibc: 2.2.5
> binutils: 2.12.90.0.1
> gcc: 2.95.4
> 
> 
> Jens-Christian Skibakk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
