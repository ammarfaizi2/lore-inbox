Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271071AbUJUWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbUJUWqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271059AbUJUWlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:41:55 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:60746 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271061AbUJUWl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:41:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KDWZhLxot1Pw7SuUU9QozVkMl4W0LV+aokpcKJ4rRlBICN6T9dEt0jbNVEubJMR0DB+wSk7JBpkTYlWQ0NSvkxpk0xpefYgjMO9TXTgHSdzJewjMj1zKMz3rNXDrGZsP++bXE29AqdBHSxEZp911hjkB92rO+3Q6ct95re/xcMg=
Message-ID: <58cb370e041021154174dee2e8@mail.gmail.com>
Date: Fri, 22 Oct 2004 00:41:24 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Mark Lord <lkml@rtr.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098394554.17857.177.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca>
	 <58cb370e041021134269c05f17@mail.gmail.com> <4178232B.5000506@rtr.ca>
	 <1098394554.17857.177.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That makes a lot of sense :)

On Thu, 21 Oct 2004 22:35:54 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2004-10-21 at 21:59, Mark Lord wrote:
> > That kernel breaks suspend/resume on my notebooks,
> > and is a dog for disk performance.  Still, I'd happily
> > port this new driver to it if there was a hope in hell
> > that the effort wouldn't be a total waste of my time.
> 
> If you can drop it into the 2.6-ac patches that would be great and
> I will merge it from review of the current code. That should have
> correct IDE locking and also possibly correct PCI IDE locking (actually
> I need to fix one detail).
> 
> Having a cardbus IDE adapter would be a godsend for my testing so I'll
> see if I can find a source of them over here too for brutalising the
> code.
> 
> The only visible difference is that we pass a hwif to the unregister
> functions in the -ac tree.
> 
> Alan
