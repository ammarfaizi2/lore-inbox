Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUJAJHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUJAJHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 05:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbUJAJHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 05:07:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:58295 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269508AbUJAJG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 05:06:56 -0400
Date: Fri, 1 Oct 2004 11:04:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: George Anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, Ulrich Drepper <drepper@redhat.com>,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
In-Reply-To: <415B4FEE.2000209@mvista.com>
Message-ID: <Pine.LNX.4.61.0410011054210.3887@jjulnx.backbone.dif.dk>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
 <415B0C9E.5060000@mvista.com> <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
 <415B4FEE.2000209@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, George Anzinger wrote:

> Date: Wed, 29 Sep 2004 17:14:38 -0700
> From: George Anzinger <george@mvista.com>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: Christoph Lameter <clameter@sgi.com>, Ulrich Drepper <drepper@redhat.com>,
>     johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
>     linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
> Subject: Re: patches inline in mail
> 
> Jesper Juhl wrote:
> > Unrelated to the CLOCK_PROCESS/THREAD_CPUTIME_ID discussion, just wanted to
> > comment on the 'patches inline vs attached' bit.
> > 
> > On Wed, 29 Sep 2004, George Anzinger wrote:
> > 
> > 
> > > Christoph Lameter wrote:
> > > 
> > > > On Wed, 29 Sep 2004, George Anzinger wrote:
> > > > 
> > > > 
> > > > > Christoph Lameter wrote:
> > > > > 
> > > > > Please, when sending patches, attach them.  This avoids problems with
> > > > > mailers,
> > > > > on both ends, messing with white space.  They still appear in line, at
> > > > > least in
> > > > > some mailers (mozilla in my case).
> > > > 
> > > > 
> > > > The custom on lkml, for Linus and Andrew is to send them inline. I also
> > > > prefer them inline. Will try to remember sending attachments when
> > > > sending a
> > > > patch to you.
> > > 
> > > I think they WILL be inline as well as attached if you attach them.  The
> > > difference is that in both presentations neither mailer will mess with
> > > white
> > > space.  This means that long lines will not be wrapped and tabs vs space
> > > will
> > > not be changed.
> > > 
> > 
> > Not all mailers show attachments inline. Mailers that do usually depend on
> > the mimetype of the attachment when choosing to show inline or not. pine (my
> > personal favorite) show attachments with a text/plain and similar mime-type
> > inline, but a not all mailers use that (I see a lot of attached patches on
> > lkml that don't show inline, and that's somewhat annoying).
> 
> So we should make sure that the mailer uses the right mime-type.  I suppose
> that depends on the mailer?
> > 
> > It's also harder to reply and comment on bits of a patch when your mailer
> > does not include attachments inline in a reply (even if it did show them
> > inline while reading the mail).
> > Having to save the patch, open it in a text editor and then cut'n'paste bits
> > of it into the reply mail is a pain. Same goes for having to save & open it
> > in order to read it in the first place.
> 
> We agree.  Still, I have been bitten too many times by misshandled white space
> to trust pure inlineing.  Likewise on picking it up one would usually past it
> in the mail (I suppose) where as the attachment is through the mailer and less
> prone to missing a character.
> 

When I include patches inline in mails I use pine's "Read File" 
functionality. Pressing CTRL+R and then specifying a filename causes pine 
to read the file and place it inline exactely as read from the file. So no 
whitespace damage by cut'n'paste. 
I don't know, but I would suspect that other mailers would have similar 
functionality.??


> The best answer, I think, is attachments that show as inline AND stay that way
> on the reply.
> 
That would be just as fine as plain inline, but I think it'll be difficult 
to find a way to do that that works universally with all mailers.


--
Jesper Juhl


