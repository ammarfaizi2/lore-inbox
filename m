Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUA2K5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUA2K5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:57:15 -0500
Received: from [211.167.76.68] ([211.167.76.68]:45801 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265652AbUA2K5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:57:11 -0500
Date: Thu, 29 Jan 2004 18:50:46 +0800
From: Hugang <hugang@soulinfo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040129185046.3a5502df@localhost>
In-Reply-To: <20040129102948.GA480@elf.ucw.cz>
References: <20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
	<20040126181004.GB315@elf.ucw.cz>
	<1075154452.6191.91.camel@gaston>
	<1075156310.2072.1.camel@laptop-linux>
	<20040128202217.0a1f8222@localhost>
	<1075336478.30623.317.camel@gaston>
	<20040129100554.6453e6c8@localhost>
	<1075350214.1231.18.camel@gaston>
	<20040129165119.553403f1@localhost>
	<20040129102948.GA480@elf.ucw.cz>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 11:29:48 +0100
Pavel Machek <pavel@ucw.cz> wrote:
> 
> You may want to try this one.. Maybe it helps?
> 							
I has check the kernel, I using swsusp2 patch, the process freeze like
this, but still need the patch I lastest send.

           if (flag) {
                swsusp_spin_lock_irqsave(PROCESS_SIG_MASK(current),
flags);                RECALC_SIGPENDING;
                swsusp_spin_unlock_irqrestore(PROCESS_SIG_MASK(current),
flags);            }


-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
