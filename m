Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280796AbRKBS4R>; Fri, 2 Nov 2001 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280793AbRKBSyd>; Fri, 2 Nov 2001 13:54:33 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:43080 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280788AbRKBSwj>; Fri, 2 Nov 2001 13:52:39 -0500
Message-ID: <3BE2EB6F.CB4FAF27@mandrakesoft.com>
Date: Fri, 02 Nov 2001 13:52:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Keith Owens <kaos@ocs.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13
In-Reply-To: <80D353813B1@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On  2 Nov 01 at 13:02, Keith Owens wrote:
> 
> > drivers/video/matrox/matroxfb_crtc2.o - no license, needs patch
> > drivers/video/matrox/matroxfb_g450.o - no license, needs patch
> > drivers/video/matrox/matroxfb_maven.o - no license, needs patch
> > drivers/video/matrox/matroxfb_misc.o - no license, needs patch
> 
> They are all GPL-ed. Does it mean that I have to fix that someone
> else changed kernel API during stable serie?

yes, they need MODULE_LICENSE


> P.S.: I still do not understand this MODULE_LICENSE() thing. VMware
> modules will probably contain GPL tag in next release, but kernel
> hackers refuse to look at these reports anyway (I'm not complaining,
> this is their right to ignore these reports; but if they say that they
> are doing that due to non-GPL, they lie). So I think it should be changed
> from MODULE_LICENSE() to
> MODULE_CERTIFIED_BY_LINUX_KERNEL_WORKING_GROUP("xxx says it works").
> It would match real meaning much better.

Are VMware kernel modules 100% open source?  If yes, then that is
appropriate.

If VMware kernel modules use ANY closed source libraries (foo.a) etc.,
then putting MODULE_LICENSE("GPL") on that source is wrong.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

