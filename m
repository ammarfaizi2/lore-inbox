Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTENBQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTENBQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:16:33 -0400
Received: from holomorphy.com ([66.224.33.161]:13247 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262364AbTENBQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:16:31 -0400
Date: Tue, 13 May 2003 18:29:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514012913.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514004009.GA20914@neon.pearbough.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:40:09AM +0200, axel@pearbough.net wrote:
> today compiled 2.5.69-bk8 with gcc version 3.3 20030510 and a warning in
> drivers/scsi/aic7xxx/aic7xxx_osm.c resulted in an error because of gcc flag
> -Werror.
>   gcc -Wp,-MD,drivers/scsi/aic7xxx/.aic7xxx_osm.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
> include  -Idrivers/scsi -Werror  -DKBUILD_BASENAME=aic7xxx_osm
> -DKBUILD_MODNAME=aic7xxx -c -o drivers/scsi/aic7xxx/aic7xxx_osm.o
> drivers/scsi/aic7xxx/aic7xxx_osm.c
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_map_seg':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:767: warning: integer constant is too
> large for "long" type
> make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1

Could you send in your .config? I can't reproduce it here (gcc 3.2).

Thanks.


-- wli
