Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSJDJvW>; Fri, 4 Oct 2002 05:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJDJvW>; Fri, 4 Oct 2002 05:51:22 -0400
Received: from dp.samba.org ([66.70.73.150]:4754 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261417AbSJDJvW>;
	Fri, 4 Oct 2002 05:51:22 -0400
Date: Fri, 4 Oct 2002 19:56:09 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: sleeper
Message-ID: <20021004095609.GA8809@krispykreme>
References: <20021004082918.GB4800@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004082918.GB4800@krispykreme>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sound and devfs caught in action.

Anton

Debug: sleeping function called from illegal context at slab.c:1374
Call backtrace: 
C00000000005C3B8 __might_sleep+0xf4
C000000000091764 __kmem_cache_alloc+0x268
C0000000001369AC devfsd_notify_de+0xc4
C000000000136B0C devfsd_notify+0x3c
C0000000001370E4 _devfs_unregister+0xb0
C00000000013722C devfs_unregister+0x8c
C0000000002F8474 __sound_remove_unit+0x78
C0000000002F86F8 sound_remove_unit+0x60
C000000000303BD0 snd_unregister_oss_device+0x98
C0000000003085BC snd_mixer_oss_notify_handler+0x68
C0000000002FA2F4 snd_card_free+0x2a0
D0000000001494FC Unknown
C000000000064D84 free_module+0x1c0
C000000000062F60 sys_delete_module+0x220
C00000000001F7BC sys32_delete_module+0x10
