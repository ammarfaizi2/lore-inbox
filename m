Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVLEPFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVLEPFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVLEPFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:05:31 -0500
Received: from web30607.mail.mud.yahoo.com ([68.142.200.130]:4788 "HELO
	web30607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751374AbVLEPFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:05:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bc9l3iQ4+HPeF6iDx0C0WEwqfPUctkFkLGnw8Nkx3/oThf0jM456dWCD2Tlb2Zo6mwO4oygHVQXHmPNbEHxri4S5cER3P+coIpg8hGIjw+VIc464QMiose0KKpAZp7Hy5H04DEkwyZbjsUeMNxMxwhYufLG6OLFx/n2SF44m+5Q=  ;
Message-ID: <20051205150530.91163.qmail@web30607.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 16:05:30 +0100 (CET)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Kernel BUG at page_alloc.c:117!
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1133792907.9356.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, I tested the application with a 2.4.22 kernel
and it seems to work; but I'm not the author of this
application.

The module "wdpiano" is C programme which allow us to
use the Watch-Dog Timer of the mother board (ROCKY
3703EVR).


Zine

PS : The user's manual definition of The Watch-Dog
Timer is : "a device to ensure thet standalone systems
can always recover from abnormal conditions that cause
the system to crash. These conditions may result from
an external EMI or software bug."

--- Arjan van de Ven <arjan@infradead.org> a écrit :

> On Mon, 2005-12-05 at 15:25 +0100, zine el abidine
> Hamid wrote:
> > 
> > I have to use the 2.4.18 kernel because We use an
> > application which is build on this kernel.
> 
> the good news is that userspace applications are not
> kernel version
> specific! At least in general; there are some low
> level system tools
> that sometimes are impacted (these are usually the
> "kernel helpers" like
> the insmod tool or udev). Regular applications work
> on just about any
> kernel; applications written for linux in 1994 still
> work on 2.6
> kernels!
> 
> > The module are the next one (lsmod):
> > 
> > Module                  Size  Used by    Not
> tainted
> > wdpiano                 1920   0  (unused)
> 
> what is this?
> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
