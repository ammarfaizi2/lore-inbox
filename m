Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSKEQAS>; Tue, 5 Nov 2002 11:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264882AbSKEQAS>; Tue, 5 Nov 2002 11:00:18 -0500
Received: from cis1.acs.brockport.edu ([137.21.162.241]:16063 "EHLO
	enterprise.acs.brockport.edu") by vger.kernel.org with ESMTP
	id <S264885AbSKEQAR>; Tue, 5 Nov 2002 11:00:17 -0500
Date: Tue, 5 Nov 2002 11:05:24 -0500 (EST)
From: David Liana <dlia1012@brockport.edu>
To: David Shepard <daveman@bellatlantic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:1034!
In-Reply-To: <3DC74A26.7050401@bellatlantic.net>
Message-ID: <Pine.GSO.4.04.10211051104570.3352-100000@holly.acs.brockport.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had the same error on either a shutdown or reboot.

D


On Mon, 4 Nov 2002, David Shepard wrote:

> I am running kernel 2.4.19 plain and have been doing so successfully for 
> quite some time. In the past few days, I am seeing a repeatable BUG on 
> reboot/shutdown. Please let me know if there is any more information I 
> can provide.
> 
> 
> --David Shepard
> 
> 
> * Unmounting filesystems...
> * Remounting remaining filesystems readonly...
> kernel BUG at inode.c:1034!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0156d33>]    Not tainted
> EFLAGS: 00010246
> eax: c56db150   ebx: c56db040   ecx: c56db150   edx: c56db040
> esi: 00000000   edi: c7f42e00   ebp: c910a620   esp: c47f3f00
> ds: 0018   es: 0018   ss:0018
> Process umount (pid: 7961, stackpage=c47f3000
> Stack: c11660c0 c56db040 00000296 c47f3f48 00000296 c11660c0 c56d6740 
> c56d6740
> Stack: c0157ea4 c11660c0 c56d6740 00000001 c7f42e60 00000001 c01573ad 
> c7f42e00
> Stack: c7f42ec4 c7f42e34 c910a620 c910468d c56db040 c7f42e00 c7f42e40 
> c0143207
> Call Trace:    [<c0157ea4>] [<c01573ad>] [<c910a620>] [<c910468d>] 
> [<c0143207>]
>   [<c015ad05>] [<c015add1>] [<c015ae67>] [<c01074a3>]
>  
> Code: 0f 0b 0a 04 9d bb 27 c0 e9 48 fa ff ff 55 57 56 53 83 ec 14
> /sbin/rc: line 110:   7961 Segmentation fault      umount -a -r -n -t 
> nodevfs,noproc,notmpfs >&/dev/null
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

