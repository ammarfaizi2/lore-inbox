Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSAIJkb>; Wed, 9 Jan 2002 04:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJkW>; Wed, 9 Jan 2002 04:40:22 -0500
Received: from codepoet.org ([166.70.14.212]:28428 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288384AbSAIJkL>;
	Wed, 9 Jan 2002 04:40:11 -0500
Date: Wed, 9 Jan 2002 02:40:10 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
Message-ID: <20020109094010.GA8743@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <a1gar7$12t$1@cesium.transmeta.com> <E16O998-0008Vo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16O998-0008Vo-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 09, 2002 at 03:11:22AM +0000, Alan Cox wrote:
> > One way to do this would be to create a newbrk() syscall which takes a
> > permission argument (for new pages.)
> 
> brk(), mmap().
> 
> Welcome to libc 8)

Umm.  How can libc implement mmap without the kernel
handing out the pages?  I don't get it.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
