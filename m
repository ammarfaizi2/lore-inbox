Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSA1Qjl>; Mon, 28 Jan 2002 11:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289230AbSA1Qjc>; Mon, 28 Jan 2002 11:39:32 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:24977 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289228AbSA1QjR>; Mon, 28 Jan 2002 11:39:17 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: fonts corruption with 3dfx drm module
Date: Mon, 28 Jan 2002 17:39:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Mark Zealey <mark@zealos.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020128163926Z289228-13996+13380@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 04:12:34PM +0200, Zwane Mwaikambo wrote:

> On Mon, 28 Jan 2002, Zwane Mwaikambo wrote:
> 
> > Do you guys have CONFIG_MTRR and/or CONFIG_FB_VESA enabled? Also which 
> > motherboard chipset?

MTRR, of course (do you like 2D and even 3D hardware accelerated without 
MTRR?), FB, no, chipset is a AMD 750 (Irongate C4), using X 4.1.99.1 DRI CVS.

I am with the DRI devel team and saw it occasionally with XFree86 DRI CVS 
trunk and the latest mesa-4-0-branch. At that time I had FB enabled as I 
remember right.

The current DRI stuff is "only" missing the latest XFree86 4.2.0 release 2D 
code. Update is under way.

I can _NOT_ see it without FB and currently running 
2.4.18-pre7-J6-VM-23-preempt-lock.
 
/home/nuetzel> cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 128MB: write-back, count=1
reg02: base=0xec103000 (3777MB), size=   4KB: write-combining, count=1
reg03: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=2

Voodoo5 5500 AGP.

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
