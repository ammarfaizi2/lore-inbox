Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSG3VcO>; Tue, 30 Jul 2002 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSG3VcO>; Tue, 30 Jul 2002 17:32:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61714 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316659AbSG3VcM>; Tue, 30 Jul 2002 17:32:12 -0400
Date: Tue, 30 Jul 2002 14:35:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brad Hards <bhards@bigpond.net.au>
cc: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <200207310726.05436.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jul 2002, Brad Hards wrote:
> 
> We shouldn't arbitrarily invent new types that could be trivially done with 
> standard types. Maybe we could retain existing usage for ABIs that are
> unchanged from 2.0 days, but we certainly shouldn't be making the ABI
> any worse.

I disagree. 

I actively _dislike_ those stupid standard typenames. I don't want them in 
the kernel, and they have no advantages over the standard kernel types 
that have been there for a _loong_ time.

		Linus

