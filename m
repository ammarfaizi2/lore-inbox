Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUCXVct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUCXVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:32:49 -0500
Received: from ns.suse.de ([195.135.220.2]:50622 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261980AbUCXVcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:32:47 -0500
Date: Wed, 24 Mar 2004 22:32:45 +0100
From: Olaf Hering <olh@suse.de>
To: Andreas Happe <news_0403@flatline.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-ID: <20040324213245.GA11608@suse.de>
References: <20040323232511.1346842a.akpm@osdl.org> <slrnc63mc2.18m.news_0403@flatline.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <slrnc63mc2.18m.news_0403@flatline.ath.cx>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Mar 24, Andreas Happe wrote:

> On 2004-03-24, Andrew Morton <akpm@osdl.org> wrote:
> > -initramfs-search-for-init.patch
> > -initramfs-search-for-init-zombie-fix.patch
> > +initramfs-search-for-init-orig.patch
> >
> >  Go back to the original, simple version of this patch.
> 
> 2.6.5-rc2-mm2 still hangs after:
> | VFS: mounted root (ext3 filesystem) readonly
> | Freeing unused kernel memory: 140kB
> 
> SysRq still works, what information would you need to solve that
> problem?

you really have this code now?

+       if (sys_access("/init", 0) == 0)
+               execute_command = "/init";
+       else
        prepare_namespace();

sysrq t would help.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
