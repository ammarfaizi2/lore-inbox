Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUI0MZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUI0MZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUI0MZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:25:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266805AbUI0MZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:25:09 -0400
Date: Mon, 27 Sep 2004 07:41:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040927104120.GA30364@logos.cnet>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096060549.10797.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:15:51PM +0100, Alan Cox wrote:
> On Gwe, 2004-09-24 at 20:58, Thomas Habets wrote:
> > And also, I'd like to see how a misbehaving airline passenger could start to 
> > gain weight not originally on the plane, causing the flight attendants to 
> > start executing people because of OOF. And IIRC most airlines don't like 
> > having women onboard who are way too pregnant, so no forking either.
> 
> The zero over commit code makes sure that we have enough swap/memory for
> fillable address space. It means the application will always be told
> when it takes an action that it cannot do it, rather than finding out
> later and being killed.

BTW,I think a lot of applications do not gracefully handle -ENOMEM?

I suppose most of them just fail and bailout with -ENOMEM.

No?

