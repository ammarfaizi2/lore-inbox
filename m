Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273242AbRINAu7>; Thu, 13 Sep 2001 20:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273241AbRINAuu>; Thu, 13 Sep 2001 20:50:50 -0400
Received: from [211.100.87.230] ([211.100.87.230]:11943 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S273239AbRINAuc>;
	Thu, 13 Sep 2001 20:50:32 -0400
Date: Fri, 14 Sep 2001 08:51:03 +0800
From: hugang <linuxbest@soul.com.cn>
To: "John D. Kim" <johnkim@aslab.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <gero@gkminix.han.de>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: A patch for dhcp and nfsroot.
Message-Id: <20010914085103.493e30b1.linuxbest@soul.com.cn>
In-Reply-To: <Pine.LNX.4.31.0109131044220.18725-100000@postbox.aslab.com>
In-Reply-To: <20010829081411.753c1d1b.linuxbest@soul.com.cn>
	<Pine.LNX.4.31.0109131044220.18725-100000@postbox.aslab.com>
Organization: soul
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001 10:47:18 -0700 (PDT)
"John D. Kim" <johnkim@aslab.com> wrote:
>Hi hugang.  This came just in time to fix a problem I'm having.  But when
>I try to load it using insmod, it complains that it cannot find the kernel
>it was built for.  Have you got this working successfully?  Which kernel
>are you running?  I'm running 2.4.9-ac8.
>
>I'm also using this in an initrd setting.  I'm trying to load the kernel
>and the initrd image, have the ipconfig modules get stuff through dhcp and
>then nfsroot.  Can you think of what might be causing this problem?  I'm
>no kernel hacker, but I'll do what I can.
>
>
>
Thanks for test it.

Yes,it work in my labs with kernel 2.4.8 (not ac)! I use it for an linux disaster recovery solution.

It your still can use it , I put my use kernel in http://www.soul.com.cn/2.4.9/2.4.9-disaster.tar.bz2

/boot/vmlinu.gz  	kernel
/boot/initrd.img.gz	initrd.img
/lib/module		kernel modules.

Beacuse my netcard can not remote boot, I use grub .
In grub command:

bootp
root (nd)
kernel vmlinuz.gz root=/dev/nfs
initrd initrd.img.gz

I test it with eepro100 netcard.I thinks it can work with another net card.


-- 
Best Regard!
礼！
----------------------------------------------------
hugang : 胡刚 	GNU/Linux User
email  : gang_hu@soul.com.cn linuxbest@soul.com.cn
Tel    : +861068425741/2/3/4
Web    : http://www.soul.com.cn

	Beijing Soul technology Co.Ltd.
	   北京众志和达科技有限公司
----------------------------------------------------
