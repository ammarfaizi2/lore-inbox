Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSEVTvp>; Wed, 22 May 2002 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316711AbSEVTvo>; Wed, 22 May 2002 15:51:44 -0400
Received: from mail11b.verio-web.com ([161.58.148.19]:28756 "HELO
	mail-fwd.verio-web.com") by vger.kernel.org with SMTP
	id <S316709AbSEVTvo>; Wed, 22 May 2002 15:51:44 -0400
Message-ID: <017201c201ca$13054810$320e10ac@irvine.hnc.com>
Reply-To: "Kirk" <kirk@scriptdoggie.com>
From: "Kirk" <kirk@scriptdoggie.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Ambrish Verma" <averma@marantinetworks.com>
In-Reply-To: <003301c201c5$04af5620$3701a8c0@maranti.com>
Subject: Re: ipfwadm problems
Date: Wed, 22 May 2002 12:51:32 -0700
Organization: ScriptDoggie Inc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does iptables have or allow IP Masqurading?  This is really what I'm trying
to do as I have a network behind my linux server (acting as a router) and
need to forward packets from 192.168.0.x to my WAN port on the same Linux
server.  I had this working with ipchains until the upgrade to 2.4.18.

Thanks,
Kirk


----- Original Message -----
From: "Ambrish Verma" <averma@marantinetworks.com>
To: <kirk@scriptdoggie.com>
Sent: Wednesday, May 22, 2002 12:15 PM
Subject: Re: ipfwadm problems


In the new kernels ipchains is not included by default (probably if you put
some effort you can include it.).
There is an alternate for ipchains is available called iptables, with which
you should be able to do most of the things you expect from ipchains.

--
Ambrish


"Kirk" <kirk@scriptdoggie.com> wrote in message
news:011101c201bd$91ccccc0$320e10ac@irvine.hnc.com...
> I'm trying to issue an "ipfwadm" to create ipchains and am getting:
>
> > Generic IP Firewall Chains not in this kernel
>
> Looking for help with re-compiling the 2.4.18-2 (latest from CD's 7.3
> install).  Can someone point me in the right direction?
>
> Thanks
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


