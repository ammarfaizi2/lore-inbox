Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTDVTSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTDVTSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:18:07 -0400
Received: from c-51a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.81]:57472
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263388AbTDVTSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:18:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] cirrusfb on alpha does not compile
References: <20030422190837.GA20925@rollcage.bzimage.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 22 Apr 2003 21:29:37 +0200
In-Reply-To: <20030422190837.GA20925@rollcage.bzimage.de>
Message-ID: <yw1xr87uuy8u.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Tretkowski <tretkowski@bzimage.de> writes:

>   gcc -Wp,-MD,drivers/video/.cirrusfb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia
> sing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev56 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix in
> clude    -DKBUILD_BASENAME=cirrusfb -DKBUILD_MODNAME=cirrusfb -c -o drivers/video/cirrusfb.o drivers/video/cirrusfb.c
> drivers/video/cirrusfb.c:66:25: video/fbcon.h: No such file or directory
> drivers/video/cirrusfb.c:67:29: video/fbcon-mfb.h: No such file or directory
> drivers/video/cirrusfb.c:68:30: video/fbcon-cfb8.h: No such file or directory
> drivers/video/cirrusfb.c:69:31: video/fbcon-cfb16.h: No such file or directory
> drivers/video/cirrusfb.c:70:31: video/fbcon-cfb24.h: No such file or directory
> drivers/video/cirrusfb.c:71:31: video/fbcon-cfb32.h: No such file or directory

None of the fb drivers seem to compile on Alpha.  If noone else does
it, I'll look into it some day.  I'm not promising to fix it, though.

-- 
Måns Rullgård
mru@users.sf.net
