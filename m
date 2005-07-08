Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVGHMqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVGHMqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGHMqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:46:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42162 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262623AbVGHMqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:46:48 -0400
Date: Fri, 8 Jul 2005 14:46:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: share/private/slave a subtree
In-Reply-To: <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.61.0507081441440.3728@scrub.home>
References: <1120816072.30164.10.camel@localhost>           
 <1120816229.30164.13.camel@localhost>            <1120817463.30164.43.camel@localhost>
            <84144f0205070804171d7c9726@mail.gmail.com>           
 <Pine.LNX.4.61.0507081412280.3743@scrub.home> <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Pekka J Enberg wrote:

> On Fri, 8 Jul 2005, Pekka Enberg wrote:
> > > > +#define PNODE_MEMBER_VFS  0x01
> > > > +#define PNODE_SLAVE_VFS   0x02
> > > > Enums, please.
> 
> Roman Zippel writes:
> > Is this becoming a requirement now? I personally would rather leave that to
> > personal preference...
> 
> Hey, I just review patches. I don't get to set requirements. There's a reason
> why enums are preferred though. They define a proper name for the constant.

Who prefers that?

> It's far to easy to mess up with #defines.

Rather unlikely with such simple masks.

> They also document the code intent
> much better as you can group related constants together. 

You can't do that with defines?

bye, Roman
