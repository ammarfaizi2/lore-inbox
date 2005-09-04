Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVIDQoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVIDQoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVIDQoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:44:20 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:39667 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1750944AbVIDQoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:44:20 -0400
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Sun, 4 Sep 2005 11:44:13 -0500
User-Agent: KMail/1.8.2
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua>
In-Reply-To: <200509041549.17512.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041144.13145.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 7:49 am, Denis Vlasenko wrote:
> On Friday 02 September 2005 09:08, Alex Davis wrote:
> > ndiswrapper and driverloader will not work reliably with 4k stacks.
> > This is because of the Windoze drivers they use, to which, obviously,
> > they do not have the source. Since quite a few laptops have built-in
> > wireless cards by companies who will not release an open-source driver,
> > or won't release specs, ndiswrapper and driverloader are the only way
> > to get these cards to work.
> >   Please don't tell me to "get a linux-supported wireless card". I don't
> > want the clutter of an external wireless adapter sticking out of my
> > laptop, nor do I want to spend money on a card when I have a free and
> > working solution.
>
> Please don't tell me to "care for closed-source drivers". I don't
> want the pain of debugging crashes on the machines which run unknown code
> in kernel space.
>
> IOW, if you run closed source modules - it's _your_ problem, not ours.
> --
> vda
> -
No one is asking you to 'care' about our problems running a notebook with a 
closed source driver under ndiswrapper.  We aren't asking you to debug 
problems with them either.  All we're asking is for you to not go out of your 
way to break existing working machines, and make it difficult to run Linux on 
them.  You are talking about knowingly removing an option that allows many 
machines to currently run without problems, some of them for reasons other 
than closed source code.

If you want 4k stacks to be the default, I have no problem with that.  If you 
want to rip out the provision for 8k stacks to be selectable at build time, 
that is a different issue entirely.

Paul
