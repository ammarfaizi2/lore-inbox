Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGKPzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTGKPzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:55:10 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:21465 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S264075AbTGKPye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:54:34 -0400
Date: Fri, 11 Jul 2003 17:00:35 +0100 (BST)
From: Jon Masters <jonathan@jonmasters.org>
To: Larry McVoy <lm@bitmover.com>
cc: Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org,
       jcm@printk.net
Subject: Re: Stripped binary insertion with the GNU Linker suggestions (fwd)
In-Reply-To: <20030711153557.GB30378@work.bitmover.com>
Message-ID: <Pine.LNX.4.10.10307111655430.25244-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Larry McVoy wrote:

> On Fri, Jul 11, 2003 at 04:19:55PM +0100, Jon Masters wrote:
> > I have seen other nasty ways to do this involving converting the image to
> > byte values in very large arrays or inserting literal byte values in to
> > the output file but there just has to be a generic method for inserting
> > an image in to the middle of an output file.
> 
> No, there isn't, at least I haven't found one.

Arrgh! :-).

In that case I might take you up on the BK idea or write something using
bfd to munge the elf content - odd that it does not exist already.

The reason I want it is that I am creating a single elf output file which
is loaded in to SDRAM by a SystemACE chip and in order for that to work
correctly I need to give the appropriate tools a single elf input
containing everything where I want it to be loaded in memory.

Fun for the weekend I suppose... :-).

Jon.

