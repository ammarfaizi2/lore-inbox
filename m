Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSKNRgc>; Thu, 14 Nov 2002 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSKNRgb>; Thu, 14 Nov 2002 12:36:31 -0500
Received: from dp.samba.org ([66.70.73.150]:58092 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265098AbSKNRgQ>;
	Thu, 14 Nov 2002 12:36:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matthew Wilcox <willy@debian.org>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4 
In-reply-to: Your message of "Thu, 14 Nov 2002 12:39:40 -0000."
             <20021114123940.U30392@parcelfarce.linux.theplanet.co.uk> 
Date: Fri, 15 Nov 2002 04:33:37 +1100
Message-Id: <20021114174310.9DD642C2A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021114123940.U30392@parcelfarce.linux.theplanet.co.uk> you write:
> Rusty wrote:
> > Jgarzik wrote:
> > > Let's be more friendly to the namespace and call it something less
> > > ambiguous, like MODULE_PARAM, even if that might not be strictly true in
> > > 1% of the cases. IMO there are certainly valid local uses of 'PARAM' in
> > > kernel code.
> > 
> > I disagree. It's a param, subsuming both __setup and MODULE_PARAM.
> > The fact that it is implemented for modules is not something for the
> > driver author to be concerned about (finally).
> 
> You're both wrong ;-)  `module' != `loadable module'.

Now we're descending into sophistry.  But PARAM() is useful in (say)
init/main.c, as well, and it's a stretch to call it a module...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
