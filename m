Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbUKQIBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUKQIBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbUKQIBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:01:48 -0500
Received: from mail.renesas.com ([202.234.163.13]:61137 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262225AbUKQIBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:01:46 -0500
Date: Wed, 17 Nov 2004 17:01:26 +0900 (JST)
Message-Id: <20041117.170126.728242515.takata.hirokazu@renesas.com>
To: sam@ravnborg.org
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1-bk21] [m32r] Update defconfig files
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041113220918.GD8319@mars.ravnborg.org>
References: <20041112.173414.28782636.takata.hirokazu@renesas.com>
	<20041113220918.GD8319@mars.ravnborg.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment, Sam.

I feel it is not so big bonus for us, because m32r doesn't have 
plenty of platforms like ppc/arm so far.

I'm not sure we should seperate defconfigs with dot.gdbinit files for m32r.
Hopefully, I would reconsider if we had to support more target platforms...

-- Takata


From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2.6.10-rc1-bk21] [m32r] Update defconfig files
Date: Sat, 13 Nov 2004 23:09:18 +0100
> On Fri, Nov 12, 2004 at 05:34:14PM +0900, Hirokazu Takata wrote:
> > Hello,
> > 
> > This patch is for updating defconfig files for m32r.
> > All defconfig files are regenerated for 2.6.10-rc1-bk21.
> > 
> > Thanks.
> > 
> > Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> > ---
> > 
> >  arch/m32r/defconfig                       |  152 +++++-
> >  arch/m32r/m32700ut/defconfig.m32700ut.smp |  130 ++++-
> >  arch/m32r/m32700ut/defconfig.m32700ut.up  |  130 ++++-
> >  arch/m32r/mappi/defconfig.nommu           |  109 +++-
> >  arch/m32r/mappi/defconfig.smp             |  104 +++-
> >  arch/m32r/mappi/defconfig.up              |  104 +++-
> >  arch/m32r/mappi2/defconfig.vdec2          |  698 ++++++++++++++++++++++++++++++
> >  arch/m32r/oaks32r/defconfig.nommu         |   93 +++
> >  arch/m32r/opsput/defconfig.opsput         |  114 +++-
> >  9 files changed, 1424 insertions(+), 210 deletions(-)
> Any reason why you do not place them in arch/m32r/configs like ppc and arm?
> If you name them like arm/ppc then you play like the rest of the archs.
> As an added bonus the config options shows up in "make help".
> 
> You should also consider using the newly introduced KBUILD_DEFCONFIG.
> Let it point to the most 'popular' of the arch/m32r/configs/defconfig* files
> then you do not need the file arch/m32r/defconfig.
> 
> 	Sam
> 
