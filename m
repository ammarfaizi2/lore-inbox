Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUGSXc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUGSXc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 19:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUGSXc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 19:32:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264723AbUGSXc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 19:32:56 -0400
Date: Mon, 19 Jul 2004 19:32:14 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Meelis Roos <mroos@linux.ee>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TEA crypto in 2.4: undefined MODULE_ALIAS
In-Reply-To: <Pine.GSO.4.44.0407191253370.14892-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.58.0407191931390.1972@devserv.devel.redhat.com>
References: <Pine.GSO.4.44.0407191253370.14892-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004, Meelis Roos wrote:

> I am trying to compile 2.4.27-BK on PPC and activated TEA crypto option
> as a module. I get this compile error:
> 
> gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/mroos/compile/linux-2.4/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=tea  -c -o tea.o tea.c
> tea.c:242: error: parse error before string constant
> tea.c:242: warning: type defaults to `int' in declaration of `MODULE_ALIAS'
> tea.c:242: warning: function declaration isn't a prototype
> tea.c:242: warning: data definition has no type or storage class
> 

Probably remove the line from the 2.4 version.


- James
-- 
James Morris
<jmorris@redhat.com>

