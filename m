Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130638AbQKGDZM>; Mon, 6 Nov 2000 22:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbQKGDZD>; Mon, 6 Nov 2000 22:25:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:20234 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130638AbQKGDYw>;
	Mon, 6 Nov 2000 22:24:52 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tomasz Motylewski <motyl@stan.chemie.unibas.ch>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build 
In-Reply-To: Your message of "Tue, 07 Nov 2000 01:20:36 BST."
             <Pine.LNX.4.21.0011070059120.24007-100000@crds.chemie.unibas.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 14:24:45 +1100
Message-ID: <9769.973567485@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 01:20:36 +0100 (CET), 
Tomasz Motylewski <motyl@stan.chemie.unibas.ch> wrote:
>2.2.18pre19:
>And , whose idea was that "make modules_install" should create
>/lib/modules/..../build symlink to the kernel sources?
>It really breakes depmod -a (modutils 2.3.11)(*)
>
>(*) I could find a workaround, but if it hits me, it will hit lots of other
>people not reading linux-kernel regularly. In my opinion upgrading stable
>kernels should work without any modifications to the existing system.

Agreed, I was unhappy that the build symlink was added to 2.2 kernels.
Now you need modutils >= 2.3.14 for 2.2 kernels :(.  But nobody asks
me, I'm just the kernel module.[ch] and modutils maintainer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
