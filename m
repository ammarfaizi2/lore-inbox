Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVGXShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVGXShz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVGXShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 14:37:55 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:9234 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261418AbVGXSha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 14:37:30 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: gbakos@cfa.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel page size explanation
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
	<9a87484905072118207a85970e@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: no job too big... no job.
Date: Sun, 24 Jul 2005 19:37:18 +0100
In-Reply-To: <9a87484905072118207a85970e@mail.gmail.com> (Jesper Juhl's
 message of "22 Jul 2005 02:22:04 +0100")
Message-ID: <87d5p8aw4h.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2005, Jesper Juhl suggested tentatively:
> You can
>  A) look in the .config file for your current kernel (if your arch
> supports different page sizes at all).
>  B) You can use the  getpagesize(2) syscall at runtime. getpagesize()
> returns the nr of bytes in a page - man getpagesize - I'm not sure
> that's universally supported though.
>  C) You can look at /proc/cpuinfo or /proc/meminfo , IIRC some archs
> report page size there - not quite sure, can't remember...

D) getconf PAGE_SIZE should work, although what it does on arches
   with variable page sizes isn't clear to me.

-- 
`But of course, GR is the very best relativity for the masses.'
 --- Wayne Throop
