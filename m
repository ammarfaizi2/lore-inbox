Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVCQJSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVCQJSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVCQJSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:18:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:48841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263022AbVCQJS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:18:26 -0500
Date: Thu, 17 Mar 2005 01:18:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-Id: <20050317011811.69062aa0.akpm@osdl.org>
In-Reply-To: <200503170942.25833.petkov@uni-muenster.de>
References: <20050316040654.62881834.akpm@osdl.org>
	<200503170942.25833.petkov@uni-muenster.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <petkov@uni-muenster.de> wrote:
>
> Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
>  Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk failed.
>  Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root (ext2 filesystem) readonly.
>  Mar 17 09:19:28 zmei kernel: [    4.112465] Freeing unused kernel memory: 188k freed
>  Mar 17 09:19:28 zmei kernel: [    4.142002] logips2pp: Detected unknown logitech mouse model 1
>  Mar 17 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on isa0060/serio1
>  [EOF]
>  <-- and here it stops waiting forever. What actually has to come next is the init 
>  process, i.e. something of the likes of:
>  INIT version x.xx loading
>  but it doesn't. And by the way, how do you debug this? serial console?

Serial console would be useful.  Do sysrq-P and sysrq-T provide any info?
