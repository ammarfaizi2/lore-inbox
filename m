Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267666AbSLTAaQ>; Thu, 19 Dec 2002 19:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbSLTAaQ>; Thu, 19 Dec 2002 19:30:16 -0500
Received: from dp.samba.org ([66.70.73.150]:13514 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267666AbSLTAaO>;
	Thu, 19 Dec 2002 19:30:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools 0.9.5 
In-reply-to: Your message of "Thu, 19 Dec 2002 16:29:42 BST."
             <20021219152942.GD26389@louise.pinerecords.com> 
Date: Fri, 20 Dec 2002 11:37:27 +1100
Message-Id: <20021220003818.0D5622C32C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021219152942.GD26389@louise.pinerecords.com> you write:
> $ uname -r
> 2.4.20
> 
> [compile and install 2.5.52]
> 
> still in 2.4.20:
> # depmod -V
> module-init-tools 0.9.5
> # depmod -ae -F /boot/System.map-2.5.52 2.5.52
> #
> 
> [reboot into 2.5.52]
> 
> # modprobe pcnet32
> FATAL: module pcnet32 not found.
> # depmod -ae
> # modprobe pcnet32
> #
> 
> Hmm?

I can't reproduce that here (the two produce identical results with my
config).  Can you send the contents of /lib/modules/2.5.52/modules.dep
produced after each run?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
