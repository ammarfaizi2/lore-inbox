Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbRECCTb>; Wed, 2 May 2001 22:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135532AbRECCTV>; Wed, 2 May 2001 22:19:21 -0400
Received: from [195.50.100.22] ([195.50.100.22]:51918 "HELO
	emasgn01.eu.rabobank.com") by vger.kernel.org with SMTP
	id <S133084AbRECCTI>; Wed, 2 May 2001 22:19:08 -0400
X-Server-Uuid: df2cf700-468c-11d4-860a-00508b951a52
Message-ID: <1E8992B3CD28D4119D5B00508B08EC5627E8A5@sinxsn02.ap.rabobank.com>
From: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
To: "'J Sloan'" <jjs@toyota.com>
cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [OT] Re: Linux NAT questions- (kernel upgrade??)
Date: Thu, 3 May 2001 09:20:37 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 16EE60981126-03-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the Red Hat 7,  below are my kernel version.  I feel Red Hat 7 is
quite new, although RH 7.1 has just come out.  How come it still say that my
kernel version is old.

[root@guava simc]# uname -a
Linux guava 2.2.16-22 #1 Tue Aug 22 16:16:55 EDT 2000 i586 unknown
[root@guava simc]#

-----Original Message-----
From: J Sloan [mailto:jjs@toyota.com]
Sent: Thursday, May 03, 2001 1:24 AM
To: Sim, CT (Chee Tong)
Cc: Linux kernel
Subject: [OT] Re: Linux NAT questions- (kernel upgrade??)


"Sim, CT (Chee Tong)" schrieb:

> Hi.. I follow your instruction, but I encounter this issue, my kernel need
> to be upgrade? MAy I know how to determine the current kernel version

uname -a

> and
> how to upgrade it??

Either upgrade to a distro that includes the new kernel
(e.g. latest SuSE or Red Hat) or download kernel source
and compile. It might be helpful to provide the distribution
and version you are using (Red Hat 6.2, Slackware 7,
Debian Potato, etc)

> [root@guava /root]# iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160
-i
> eth1 -j D
> NAT --to-destination 192.168.200.2
> iptables v1.1.1: can't initialize iptables table `nat': iptables who? (do
> you need to insm
> od?)
> Perhaps iptables or your kernel needs to be upgraded.
>
> [root@guava simc]# rpm -ivh iptables-1_2_0-6_i386.rpm
> error: failed dependencies:
>         kernel >= 2.4.0 is needed by iptables-1.2.0-6

Yes, of course iptables won't work with the old kernel.
If you want to stay with the old kernel, you must use
ipchains instead.

cu

Jup


==================================================================
De informatie opgenomen in dit bericht kan vertrouwelijk zijn en 
is uitsluitend bestemd voor de geadresseerde. Indien u dit bericht 
onterecht ontvangt wordt u verzocht de inhoud niet te gebruiken en 
de afzender direct te informeren door het bericht te retourneren. 
==================================================================
The information contained in this message may be confidential 
and is intended to be exclusively for the addressee. Should you 
receive this message unintentionally, please do not use the contents 
herein and notify the sender immediately by return e-mail.


==================================================================

