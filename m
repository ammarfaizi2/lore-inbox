Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLQBHU>; Mon, 16 Dec 2002 20:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLQBHU>; Mon, 16 Dec 2002 20:07:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42508 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262826AbSLQBHT>;
	Mon, 16 Dec 2002 20:07:19 -0500
Date: Mon, 16 Dec 2002 17:12:54 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Andr=E9?= Cruz <afafc@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB troubles in 2.5 kernels
Message-ID: <20021217011254.GA18495@kroah.com>
References: <1040086793.1083.4.camel@giga.netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1040086793.1083.4.camel@giga.netcabo.pt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:59:54AM +0000, André Cruz wrote:
> 
> usb-storage: act_altsetting is 0
> usb-storage: id_index calculated to be: 95
> usb-storage: Array length appears to be: 97
> usb-storage: USB Mass Storage device detected
> usb-storage: Endpoints: In: 0xef283ef4 Out: 0xef283ee0 Int: 0x00000000
> (Period 0)
> usb-storage: New GUID 0aec5010aec501000001a003
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000002
>  printing eip:
> c02aaede
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<c02aaede>]    Not tainted
> EFLAGS: 00010202
> eax: 00000001   ebx: 00000020   ecx: ef283ee0   edx: 00000000
> esi: 00000000   edi: ef283ef4   ebp: ef280600   esp: efc5bd4c
> ds: 0068   es: 0068   ss: 0068
> Process khubd (pid: 4, threadinfo=efc5a000 task=c17af240)
> Stack: ef280600 00000000 00000174 0001a003 00000000 efb2aa00 ef288560
> ef280604
>        c174b968 c03d624c c0137541 c174b968 00000000 c174b9b8 00000000
> 00000246
>        c03d624c 000001ff effe83d0 00000000 eeb09ea0 eeb09098 c01623d0
> eeb09ea0
> Call Trace: [<c0137541>]  [<c01623d0>]  [<c013a38e>]  [<c028ff07>] 
> [<c0200c65>]  [<c0200cff>]  [<c0200ed4>]  [<c01fff70>]  [<c029119c>] 
> [<c0293546>]  [<c02939be>]  [<c0122265>]  [<c0293a65>]  [<c011e4c0>] 
> [<c0293a30>]  [<c0109249>]
> Code: 0f b6 46 02 24 0f 88 85 9e 00 00 00 0f b6 46 06 8d 75 30 88
> 
> 
> Can anyone help with any of these problems?

Can you run that oops through ksymoops and send it to the
linux-usb-devel mailing list?

thanks,

greg k-h
