Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311286AbSCQGQ2>; Sun, 17 Mar 2002 01:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311316AbSCQGQT>; Sun, 17 Mar 2002 01:16:19 -0500
Received: from codepoet.org ([166.70.14.212]:35757 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S311286AbSCQGQH>;
	Sun, 17 Mar 2002 01:16:07 -0500
Date: Sat, 16 Mar 2002 23:16:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Hellwig <hch@codepoet.org>, roms@lpg.ticalc.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: your mail, [PATCH] tipar
Message-ID: <20020317061609.GA27941@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Hellwig <hch@codepoet.org>, roms@lpg.ticalc.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16lHKt-0007dn-00@the-village.bc.nu> <3C935F7A.AD380542@free.fr> <20020316200651.A9072@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316200651.A9072@infradead.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Mar 16, 2002 at 08:06:51PM +0000, Christoph Hellwig wrote:
> > +static devfs_handle_t devfs_handle = NULL;
> > +static unsigned int tp_count = 0;   /* tipar count */
> > +static unsigned long opened = 0;    /* opened devices */
> 
> Variables in .bcc are auto-zeroed - you can drop the intialization.

I'm sure all the users of elks will be disappointed that their
compiler auto zeros all variables.  :)

I think you mean .bss...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
