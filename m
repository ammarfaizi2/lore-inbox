Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSEESfC>; Sun, 5 May 2002 14:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313304AbSEESfB>; Sun, 5 May 2002 14:35:01 -0400
Received: from web14102.mail.yahoo.com ([216.136.172.132]:53044 "HELO
	web14102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313300AbSEESe7>; Sun, 5 May 2002 14:34:59 -0400
Message-ID: <20020505183451.98763.qmail@web14102.mail.yahoo.com>
Date: Sun, 5 May 2002 20:34:51 +0200 (CEST)
From: =?iso-8859-1?q?william=20stinson?= <wstinsonfr@yahoo.fr>
Subject: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

as vanilla linux 2.5.13 compiled beautifully for me
last night one I couldn't resist the temptation to
boot it up and give it a whirl on my workstation (a
monoprocessor AMD  ATHLON on VIA motherboard with
recent 20GB IDE disk and EXT2 file system, NVIDIA
video card). 

Boot went OK until a message something like "checking
filesystems - check forced -mounted  31 times without
verification - verifying now". Shortly afterwards I
got an OOPS message. 


EIP : 0010: [<c01d59cb> Not Tainted
....
<0> Kernel Panic: Aiee, killing interrupt handler! In
interrupt handler - not syncing

Not to worry I try to reboot my stable kernel - this
fails at the mount command (library's needed by mount
command are missing). Impossible to login (password
file must be corrupted too). 

With the rescue disk I run e2fsck and home partition
is  dead (bad superblocks) and nothing recoverable.
The root file system is also corrupted (bad
superblocks but not as badly as home). I have some
other partitions which I haven't checked yet - maybe
some of them survived. 

As I am not subscribed to the list please CC me in any
response. If I can recover the kernel compile I will
try to give some configuration options and try to
decode the full oops message. More details available
on request.

Best regards
William Stinson (wstinsonfr@yahoo.fr.nospam)
 
P.S. 

 The hard disk is using VIA bus master PCI IDE and the
distribution is a "vanilla" mandrake 8.1. I have a
REALTEK  RTL8029 Ethernet Adaptor. USB is with VIA
VT83C572/VT82C586 PCI to VIA Universal Host
controller. 

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
