Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTENB3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTENB3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:29:11 -0400
Received: from dsl-213-023-064-254.arcor-ip.net ([213.23.64.254]:6846 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S262347AbTENB3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:29:08 -0400
Date: Wed, 14 May 2003 03:41:07 +0200
From: axel@pearbough.net
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514014107.GA20686@neon.pearbough.net>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030514004009.GA20914@neon.pearbough.net> <20030514012913.GG8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20030514012913.GG8978@holomorphy.com>
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi William!

On Tue, 13 May 2003, William Lee Irwin III wrote:

> On Wed, May 14, 2003 at 02:40:09AM +0200, axel@pearbough.net wrote:
> > today compiled 2.5.69-bk8 with gcc version 3.3 20030510 and a warning in
> > drivers/scsi/aic7xxx/aic7xxx_osm.c resulted in an error because of gcc flag
> > -Werror.
> >   gcc -Wp,-MD,drivers/scsi/aic7xxx/.aic7xxx_osm.o.d -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586
> > -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
> > include  -Idrivers/scsi -Werror  -DKBUILD_BASENAME=aic7xxx_osm
> > -DKBUILD_MODNAME=aic7xxx -c -o drivers/scsi/aic7xxx/aic7xxx_osm.o
> > drivers/scsi/aic7xxx/aic7xxx_osm.c
> > drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_map_seg':
> > drivers/scsi/aic7xxx/aic7xxx_osm.c:767: warning: integer constant is too
> > large for "long" type
> > make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1
> 
> Could you send in your .config? I can't reproduce it here (gcc 3.2).

Here you go...

Best regards,
Axel Siebenwirth

--CE+1k2dSO48ffgeK
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config-2.5.69-bk8.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--
