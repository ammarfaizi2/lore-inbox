Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVEDD2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVEDD2C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 23:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVEDD2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 23:28:02 -0400
Received: from mx1.berrymount.net ([82.92.47.16]:56663 "EHLO
	mx1.berrymount.net") by vger.kernel.org with ESMTP id S261986AbVEDD1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 23:27:51 -0400
Date: Wed, 4 May 2005 05:27:47 +0200
From: Rob van Nieuwkerk <robn@berrymount.nl>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Rob van Nieuwkerk <robn@berrymount.nl>, Greg Kroah <greg@kroah.com>,
       Luc Saillard <luc@saillard.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The return of PWC
Message-Id: <20050504052747.76f3e9c2.robn@berrymount.nl>
In-Reply-To: <200505020229.35129@smcc.demon.nl>
References: <200505020229.35129@smcc.demon.nl>
Organization: Berrymount Automation B.V.
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-URL: http://www.berrymount.nl/
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 02:29:35 +0200
"Nemosoft Unv." <nemosoft@smcc.demon.nl> wrote:

> I've been out of the loop for a while, but today I was informed that PWC is 
> about to return to the main Linux kernel tree, in some form. In fact, it's 
> already in 2.4.12rc3.
> 
> Unfortunately, the current implementation is not acceptable. First, there 
> are still some references to the old website 
> (http://www.smcc.demon.nl/webcam) en e-mail address. But that's no big 
> deal. What's more of a problem, though, is the decompressor code that is 
> being included.
> 
> In case you hadn't noticed, that code has been reverse compiled (I would not 
> even call it "reverse engineered"), and is simply illegal. Maybe not in 
> every country, but certainly in some. There are still some intellectual 
> property rights being violated here, you know, and I'm surprised at the 
> contempt you and Linux kernel maintainers show in this regard for a few 
> lines of the law.
> 
> Now don't get started on "it was GPL code before you left bla bla" or "you 
> should not have abonded the project bla bla blah" and "this court here has 
> ruled reverse engineering is allowed and so on mumble mumble". 
> 
> I abandoned the project, true. But PWC was (and is) GPL, so if somebody  
> wanted to do the maintenance, that's fine because that is the intent, after 
> all. Even if that person grabbed the pre-compiled binaries and started 
> maintaining with that, that would have been borderline, but okay. But 
> you're crossing the line here with PWCX (the decompressor). If it was 
> truely reverse engineered, by studying the bitstream and trying to figure 
> out the algorithms, then that would have been a remarkable feat. But how 
> dare you decompile binary code, slap a GPL header on it and try to return 
> it to the kernel as if everything's alright now?
> 
> Anyway, I'll inform my contacts at Philips tomorrow. I don't know how they 
> will react; maybe they'll go nuts, maybe they'll let it pass quitely; it's 
> hard to tell. Either way, you're putting yourself in a precarious situation 
> here. Clearly, this code was not intended to be included in the kernel 
> source, it has been obtained by rather dubious means and, above all, I 
> don't think the GPL was ever intended for this kind of "relabelling". I 
> call it theft.
> 
> So I seriously suggest you do not put the module back into the kernel in 
> this form.

Oh boy, it's Nemosoft time again ..

Just some interesting information for people not familiar with
you and the PWC story:

    +--------------------------------------------------------------+
    | The NDA you signed with Philips concerning the decompression |
    | algorithms used by PWC HAS EXPIRED ALMOST 2 YEARS AGO !!!    |
    +--------------------------------------------------------------+

You have stated this yourself on Wed, 25 Aug 2004 00:58:24 +0200.

It appears to me that you are very unhappy about the fact that your
childish attempt to hurt the PWC(X) users by removing your PWC stuff
from your website did not work at all.  The only result was that we very
soon had a nice completely open source driver for PWCX and that nobody
depends on you and your binary-only driver anymore.  This is perfect,
thank you very much for your actions ..

I think it's just *YOU* who doesn't like the idea of an open source PWC
decompressor, not Philips.  Maybe your Philips contacts will be able to
convince you that you're wrong ..

	greetings,
	Rob van Nieuwkerk
