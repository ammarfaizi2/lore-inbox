Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264698AbSJUCbz>; Sun, 20 Oct 2002 22:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSJUCby>; Sun, 20 Oct 2002 22:31:54 -0400
Received: from services.cam.org ([198.73.180.252]:1738 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264696AbSJUCbx>;
	Sun, 20 Oct 2002 22:31:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.44-mm1
Date: Sun, 20 Oct 2002 22:32:47 -0400
User-Agent: KMail/1.4.3
References: <3DB2FFEA.4048E82@digeo.com>
In-Reply-To: <3DB2FFEA.4048E82@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202232.47601.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like something was missed (UP config):

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.44-mm1; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.44-mm1/kernel/drivers/char/agp/agpgart.o
depmod:         page_states__per_cpu
depmod: *** Unresolved symbols in /lib/modules/2.5.44-mm1/kernel/drivers/char/drm/mga.o
depmod:         page_states__per_cpu
depmod: *** Unresolved symbols in /lib/modules/2.5.44-mm1/kernel/fs/ext3/ext3.o
depmod:         posix_acl_create_masq
depmod:         posix_acl_permission
depmod:         posix_acl_clone
depmod:         posix_acl_alloc
depmod:         posix_acl_chmod_masq
depmod:         posix_acl_valid
depmod:         posix_acl_equiv_mode
depmod: *** Unresolved symbols in /lib/modules/2.5.44-mm1/kernel/net/packet/af_packet.o
depmod:         page_states__per_cpu
depmod: *** Unresolved symbols in /lib/modules/2.5.44-mm1/kernel/sound/core/snd.o
depmod:         page_states__per_cpu

Hope this helps
Ed


