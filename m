Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293014AbSBVVyh>; Fri, 22 Feb 2002 16:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293015AbSBVVy1>; Fri, 22 Feb 2002 16:54:27 -0500
Received: from codepoet.org ([166.70.14.212]:12008 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293014AbSBVVyX>;
	Fri, 22 Feb 2002 16:54:23 -0500
Date: Fri, 22 Feb 2002 14:54:24 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <greg@kroah.com>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222215424.GC30290@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg KH <greg@kroah.com>,
	=?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020222200750.GE9558@kroah.com> <20020221221842.V1779-100000@gerard> <20020222204157.GG9558@kroah.com> <20020222213014.GB30290@codepoet.org> <20020222214225.GA10333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222214225.GA10333@kroah.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 22, 2002 at 01:42:25PM -0800, Greg KH wrote:
> Hm, I didn't try the 'cat' test, but I did successfully unplug and then
> add a card, and then spin up the drives attached to that drive.  But
> that was a long time ago.  Things might have changed since then.
> 
> This is with a cardbus device, right?  I have never looked into them
> before.

Yup.  One of these: 
    http://www.adaptec.com/worldwide/product/proddetail.html?prodkey=APA-1480B
which I have been using to connect my MO drive to my laptop.  I'm
happy to provide details.  I spent about two hours last week
digging through the various layers trying to understand how the
SCSI layer had leftover state.  I found one little bug, but had
to move on to other things before I'd found the cause,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
