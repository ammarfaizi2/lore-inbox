Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVFJHLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVFJHLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFJHLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:11:46 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:6259 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262495AbVFJHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:11:26 -0400
Message-ID: <20050610071121.88587.qmail@web25805.mail.ukl.yahoo.com>
Date: Fri, 10 Jun 2005 09:11:21 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
To: Denis Vlasenko <vda@ilport.com.ua>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200506101003.24835.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Denis Vlasenko <vda@ilport.com.ua> a écrit :

> On Thursday 09 June 2005 18:12, Russell King wrote:
> > On Thu, Jun 09, 2005 at 04:22:49PM +0200, moreau francis wrote:
> > > --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > > > Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > > > > 
> > > > > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > > > > Do you know how I could implement such exclusive mode (the one I
> described)
> > > > ?
> > > > > 
> > > > This is handled through lock files, google for LCK..ttyS0
> > > >
> > > 
> > > This lock mechanism is a convention but nothing prevent a user
> application to
> > > issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...
> > 
> > Which is absolutely necessary to work if you think about an application
> > like minicom and its file transfer helpers, which may need to re-open
> > the serial port.
> > 
> > TTY locking is done via lock files only, and all non-helper applications
> > must coordinate their access via the lock files.  There is no other
> > mechanism.
> 
> I think original reporter is saying that TIOEXCL is nearly useless then.
> --

yes it is what I was trying to say....



	
	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
