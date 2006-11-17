Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755613AbWKQKHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbWKQKHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755623AbWKQKHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:07:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755610AbWKQKHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:07:11 -0500
Date: Fri, 17 Nov 2006 05:05:59 -0500
From: Alan Cox <alan@redhat.com>
To: Ioan Ionita <opslynx@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, htejun@gmail.com, alan@redhat.com
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
Message-ID: <20061117100559.GA10275@devserv.devel.redhat.com>
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com> <20061116235048.3cd91beb@localhost.localdomain> <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com> <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 08:34:03PM -0500, Ioan Ionita wrote:
> >ata2.00: limiting speed to UDMA/25
> >ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >ata2.00: (BMDMA stat 0x20)
> >ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)

etc.. - yes known. Something in the core code but not yet fixed (and I've
not had time to look at this).

