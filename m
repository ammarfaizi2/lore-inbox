Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293001AbSBVVay>; Fri, 22 Feb 2002 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293003AbSBVVao>; Fri, 22 Feb 2002 16:30:44 -0500
Received: from codepoet.org ([166.70.14.212]:25063 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293001AbSBVVab>;
	Fri, 22 Feb 2002 16:30:31 -0500
Date: Fri, 22 Feb 2002 14:30:14 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <greg@kroah.com>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222213014.GB30290@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg KH <greg@kroah.com>,
	=?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020222200750.GE9558@kroah.com> <20020221221842.V1779-100000@gerard> <20020222204157.GG9558@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222204157.GG9558@kroah.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 22, 2002 at 12:41:57PM -0800, Greg KH wrote:
> 
> Right now I just point people to the Adaptec cards when they complain
> about their controllers not working with hotplug :)

Well, even aic7xxx actually don't do hotplug correctly either.
Or more accurately, with my Adaptec 1480B I can hotplug, and I
can then hot-unplug, but I can't hotplug again...  Just try
pulling the 1480 card and then doing a 
    cat /proc/scsi/aic7xxx/0
some time and watch all the fireworks,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
