Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277313AbRJLKIX>; Fri, 12 Oct 2001 06:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277298AbRJLKIO>; Fri, 12 Oct 2001 06:08:14 -0400
Received: from [212.77.202.3] ([212.77.202.3]:18695 "EHLO mail.cbq.com.qa")
	by vger.kernel.org with ESMTP id <S277313AbRJLKIF>;
	Fri, 12 Oct 2001 06:08:05 -0400
Message-ID: <002101c15305$9e016d00$b00b0180@TALHA>
Reply-To: "Syed Mohammad Talha" <talha@cbq.com.qa>
From: "Syed Mohammad Talha" <talha@cbq.com.qa>
To: "hanhbkernel" <hanhbkernel@yahoo.com.cn>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011012052453.72507.qmail@web15001.mail.bjs.yahoo.com>
Subject: Re: initrd problem of 2.4.10
Date: Fri, 12 Oct 2001 13:06:52 +0300
Organization: Commercial Bank of Qatar
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same problems, which I am facing and have posted a mail as well,
but so far repose has been received, please any one who can help do reply.

Regards.
Talha

----- Original Message -----
From: "hanhbkernel" <hanhbkernel@yahoo.com.cn>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, October 12, 2001 8:24 AM
Subject: initrd problem of 2.4.10


> There is no problem using the initial RAM disk
> (initrd) with kernel 2.4.9
> But with kernel 2.4.10 system reports the following
> messages:
>
> RAMDISK: compressed image found at block 0
> Freeing initrd memory: 1153k freed
> VFS: Mounted root (ext2 filesystem)
> Freeing unused kernel (memory: 224k freed)
> Kernel panic: No init found. Try passing init=option
> to kernel
>
> When I compile the 2.4.10 The following option is
> supported:
> <*> RAM disk support(128000)   Default RAM disk size
>
> [*]   Initial RAM disk (initrd) support
>
> The version of lilo is 21.6. My lilo.conf is as this:
> boot=/dev/hda
> map=/boot/map
> install=/boot/boot.b
> prompt
> timeout=50
> message=/boot/message
> linear
> default=CapitelFW-2.4.9
> image=/hda2/boot/linux-2.4.91
> label=CapitelFW-2.4.9
> initrd=/hda2/root/initrd.gz
> append="root=/dev/ram0 init=linuxrc rw"
> image=/hda2/boot/linux-2.4.10-ac
> label=CapitelFW-ac12
> initrd=/hda2/root/initrd.gz
> append="root=/dev/ram0 init=linuxrc rw"
>
>
>
> _________________________________________________________
> Do You Yahoo!? 登录免费雅虎电邮! http://mail.yahoo.com.cn
>
> <font color=#6666FF>无聊？郁闷？高兴？没理由？都来聊天吧！</font>——
> 雅虎全新聊天室! http://cn.chat.yahoo.com/c/roomlist.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

