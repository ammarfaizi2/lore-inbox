Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284954AbRLRTwp>; Tue, 18 Dec 2001 14:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284935AbRLRTvU>; Tue, 18 Dec 2001 14:51:20 -0500
Received: from pc3-stoc4-0-cust138.mid.cable.ntl.com ([213.107.175.138]:45572
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S284887AbRLRTum>; Tue, 18 Dec 2001 14:50:42 -0500
From: "Ian Chilton" <ian@ichilton.co.uk>
To: "'Tony 'Nicoya' Mantler'" <nicoya@apia.dhs.org>,
        "'David S. Miller'" <davem@redhat.com>
Cc: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.17-rc1 wont do nfs root on Javastation
Date: Tue, 18 Dec 2001 19:50:34 -0000
Message-ID: <000001c187fd$41f2ee80$0a01a8c0@dipsy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <v04003a11b84549aa834a@[24.70.162.28]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the reply!

> IP Autoconfig won't be enabled unless you pass ip=auto in the
commandline,
> or twiddle with the source to make it default to on.

Ah, of course.

I did try this already, but it was before I realised that PROLL was
eating anything I passed to the kernel.

I just modified my little hack to make it hard code: nfs=root ip=auto
and now the IP-Config stuff is happening and it's showing the
bootserver/rootserver right but for some strange reason it's getting the
IP as 67.0.0.0.

It should be 192.168.0.21 and the server config should be right as I can
still boot 2.4.1 fine...

I'll have a check around later, but if there is a reason for this
happening, maybe you could let me know...

Is 67.0.0.0 some sort of default?


Thanks!


Bye for Now,

Ian


                                  \|||/
                                  (o o)
 /-----------------------------ooO-(_)-Ooo----------------------------\
 |  Ian Chilton                    E-Mail: ian@ichilton.co.uk         |
 |  IRC Nick: GadgetMan            Backup: ian@linuxfromscratch.org   |
 |  ICQ: 16007717 & 106532995      Web   : http://www.ichilton.co.uk  |
 |--------------------------------------------------------------------|
 |          Your mouse has moved. Windows must be restarted           |
 |         for the change to take effect.  Reboot now? [ OK ]         |
 \--------------------------------------------------------------------/
 


