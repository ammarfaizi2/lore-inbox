Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310354AbSCSHnX>; Tue, 19 Mar 2002 02:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCSHnN>; Tue, 19 Mar 2002 02:43:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23813 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310354AbSCSHnG>; Tue, 19 Mar 2002 02:43:06 -0500
Message-Id: <200203190739.g2J7dTq31402@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
Date: Tue, 19 Mar 2002 09:39:01 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.10.10203181741580.676-200000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 March 2002 15:20, Mike Galbraith wrote:
> Greetings,
>
> Kernel version is 2.5.7-pre2 if that matters.
>
> I was reading lkml with a forgotten tcpdump running, when my son turned
> on his windows box, blessing me with the usual msjunk.  Is the attached
> just a tcpdump bug?  I had already read that message, and didn't really
> expect to see it again.. not in my tcpdump log anyway :)

8-(  We need SMB experts here...
I presume your box is a Linux one. 
Is this packet went from your box to win box?
What was running on your box? Samba?
Did you use smbfs?

16:42:49.412862 10.0.0.101.netbios-dgm > 10.255.255.255.netbios-dgm: 
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                bcast from your box to NetBIOS port?
>>> NBT UDP PACKET(138) Res=0x1102 ID=0x54 IP=10.0.0.101 Port=138 Length=193 
Res2=0x0 
SourceName=T1H6I3          NameType=0x00 (Workstation) 
           ^^^^^^ your hostname?
DestName= 
SMB PACKET: SMBunknown (REQUEST) 
SMB Command   =  0x43 
Error class   =  0x46 
Error code    =  20550 
Flags1        =  0x45 
Flags2        =  0x4E 
Tree ID       =  17990 
Proc ID       =  18000 
UID           =  16720 
MID           =  16707 
Word Count    =  66 
SMBError = ERROR: Unknown error (70,20550) 
--
vda
