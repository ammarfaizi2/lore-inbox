Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLZMt4>; Thu, 26 Dec 2002 07:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLZMtz>; Thu, 26 Dec 2002 07:49:55 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:51189 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261426AbSLZMtx>;
	Thu, 26 Dec 2002 07:49:53 -0500
Date: Thu, 26 Dec 2002 13:58:07 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212261258.NAA02514@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: Re: [RELEASE] module-init-tools 0.9.6
Cc: linux-kernel@vger.kernel.org, md@Linux.IT, rl@hellgate.ch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2002 20:50:00 +1100, Rusty Russell wrote:
>I'm not announcing every release, but we're coming up to 1.0 sometime
>soon, as the TODO list is shrinking rapidly: top is man pages, which
>I'll be working on now.

What is the preferred way of translating 'above' declarations
in modules.conf to modprobe.conf? I have several cases where
I use these declarations, but the most import one for me is
'above scsi_mod ide-scsi'.

Secondly, how is one supposed to look up symbols in modules
now that /proc/ksyms is gone? I'm trying to debug an oops
where the kernel dereferences a pointer into an unloaded module.

/Mikael
