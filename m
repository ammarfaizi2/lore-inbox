Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWBJXle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBJXle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWBJXle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:41:34 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:57577 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932252AbWBJXle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:41:34 -0500
Date: Sat, 11 Feb 2006 00:41:21 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc Koschewski <marc@osknowledge.org>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Message-ID: <20060210234121.GC5713@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org> <1139613834.14383.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139613834.14383.5.camel@localhost.localdomain>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g418aade4-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-02-10 23:23:54 +0000]:

> On Gwe, 2006-02-10 at 22:00 +0100, Marc Koschewski wrote:
> > than to run this as root. Couldn't cdrecord 'watch' ide load or - even better -
> > forcecast it? It knows blanking leads to inresponsiveness sometimes (even more due
> > to the fact that both devices share the same bus). Why not kind of  'renice'
> > the process that blanks?
> 
> It isn't about load. You issue a command to an ATA device and there is
> no disconnect sequence as SCSI has. That bus is now locked until the
> command completes.
> 
> There are mechanisms for certain cases like blanking and fixating that
> allow you to avoid this. Some cd record apps let you choose them.  There
> isn't anything the kernel can do however.
> 
> Alan

Alan,

	I'm curious what caused the machine to freeze now whereas it didn't some
kernels ago. I don't know when I blanked a whole CD-RW the last time. But I know
it didn't freeze the machine. OK, maybe it's caused by some setting I missed (or
enabled) but I use the config now for along time. :/

I'm also curious when DELL will release their first mobile with SCSI onboard
instead of IDE. The chips are the same size... 

Thanks anyone for clarification. There's still sooo much to learn. But the code
is here and I'll try to do my very best... ;)

Marc
