Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWGIWaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWGIWaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWGIWaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:30:22 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:42950 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161202AbWGIWaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:30:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 00:30:44 +0200
User-Agent: KMail/1.9.3
Cc: Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Arjan van de Ven <arjan@infradead.org>, Sunil Kumar <devsku@gmail.com>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607092336.44208.rjw@sisk.pl> <200607100746.25043.ncunningham@linuxmail.org>
In-Reply-To: <200607100746.25043.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100030.44678.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 23:46, Nigel Cunningham wrote:
> On Monday 10 July 2006 07:36, Rafael J. Wysocki wrote:
> > On Sunday 09 July 2006 23:06, Nigel Cunningham wrote:
> > ]-- snip --[
> >
> > > > Now there's the separate problem that we have to share _some_ code.
> > > > To an absolute minimum, we have to share the freezer code and the
> > > > code that handles devices, because it's also shared by suspend-to-RAM.
> > > > The code that handles devices is already shared, but we also _have_
> > > > _to_ share the freezer code.  Therefore, as long as suspend2 adds some
> > > > code to the freezer, it's not even close to be considerable for
> > > > merging.

(1)

> > >
> > > If Suspend2 added code in a way that broke swsusp, I would agree. But it
> > > doesn't.
> >
> > This is not a matter of any breakage or lack thereof.  The problem is that
> > the freezer is _not_ _an_ _swsusp-only_ _code_.  It is used by someone else
> > too, and having two different freezers in the tree would be _insane_,
> > because too many things depend on that.  This would be like having two
> > different memory management systems, but at a smaller scale.
> 
> Please don't start doing what Pavel does, imputing to me motives and ideas 
> that are clearly false. You know that I don't want to have two freezer 
> implementations - I've never suggested the idea or even thought of it until 
> you suggested it.

I was only trying to explain what I meant in (1).  Please don't take it
personally, I'm doing my best to make technical points only.

> My desire all along has been to improve what's already  
> there, and I still want to do that.

Same here.

> I'm sorry that I'm not submitting and resubmitting things as fast as you'd 
> like. Please try to remember that I'm not a full time programmer. I'm working 
> for Redhat one day a week and the congregation I serve four days a week.

I'm not a full time programmer too.  Now I'm just having some more free
time than usually, that's all.

> Anything I do beyond the one day is purely my time, and I have plenty of 
> other things to do too. It's not, therefore, that I want to drag my heels. 
> Rather, I simply don't have the time to get things done as quickly as you and 
> Pavel seem to be able to.

I didn't mean I'd like you to submit/resubmit things quickly.  You'll submit
them when you're ready, be it in a week or in a month, or later.  It's all up
to you. :-)

Greetings,
Rafael
