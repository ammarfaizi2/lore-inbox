Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVGHUCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVGHUCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVGHUCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:02:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8117 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262825AbVGHUAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:00:01 -0400
Date: Fri, 8 Jul 2005 21:59:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
In-Reply-To: <1120851221.9655.17.camel@localhost>
Message-ID: <Pine.LNX.4.61.0507082154090.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
  <courier.42CEC422.00001C6C@courier.cs.helsinki.fi> 
 <Pine.LNX.4.61.0507082108530.3728@scrub.home> <1120851221.9655.17.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Pekka Enberg wrote:

> On Fri, 2005-07-08 at 21:11 +0200, Roman Zippel wrote:
> > So it basically comes down to personal preference, if the original uses 
> > defines and it works fine, I don't really see a good enough reason to 
> > change it to enums, so please leave the decision to author.
> 
> (And I don't see a good enough reason to use #defines when you don't
>  absolutely have to. This is what we disagree on.)

"use" != "change".
If an author already uses defines, that's fine and in most cases there is 
no reason to change it.

> Roman, it is not as if I get to decide for the patch submitters. I
> comment on any issues _I_ have with the patch and the authors fix
> whatever they want (or what the maintainers ask for).

The point of a review is to comment on things that _need_ fixing. Less 
experienced hackers take this a requirement for their drivers to be 
included.

> P.S. Working code is not enough for the kernel. It must be maintainable
> as well.

defines are perfectly maintainable.

bye, Roman
