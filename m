Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbUBXRAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUBXRAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:00:07 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:45192 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262300AbUBXRAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:00:02 -0500
Date: Tue, 24 Feb 2004 17:59:43 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: sandr8@crocetta.org, Gautam Pagedar <gautam@cins.unipune.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: can i modify ls
Message-ID: <20040224165943.GB24370@louise.pinerecords.com>
References: <005601c3fd75$1c681510$8c01080a@crayii> <403B7402.2000008@universitari.crocetta.org> <20040224163530.GA24370@louise.pinerecords.com> <Pine.LNX.4.53.0402241139580.532@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402241139580.532@chaos>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-24 2004, Tue, 11:44 -0500
Richard B. Johnson <root@chaos.analogic.com> wrote:

> On Tue, 24 Feb 2004, Tomas Szepe wrote:
> 
> > On Feb-24 2004, Tue, 15:55 +0000
> > Alessandro Salvatori <a.salvatori@universitari.crocetta.org> wrote:
> >
> > > it's quite interesting...
> >
> > Actually, it's not.
> >
> > 1) The presence/absence of the read permission on a directory determines
> > 	whether the user will be able to list the directory's contents.
> >
> > 2) The fs permission model is enforced by the kernel.  Trying to impose
> > 	additional restrictions in userspace is fragile, futile and
> > 	an incredibly stupid idea.
> 
> If you don't have any programming tools and no access to any (like
> a banking or restrictive office environment), and there is no
> way to get any external executable files to run, i.e., no floppy
> or no shell that could possibly access one, then writing a minimal
> 'ls' program that allows the clerk to see what's in her directory
> might be useful.

So what is it exactly that prevents the admin from running /bin/chmod
in the setup you're describing?

-- 
Tomas Szepe <szepe@pinerecords.com>
