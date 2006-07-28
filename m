Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWG1OYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWG1OYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWG1OYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:24:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8677 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161174AbWG1OYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:24:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Fri, 28 Jul 2006 16:23:55 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607281055.47526.rjw@sisk.pl> <200607281658.37794.a1426z@gawab.com>
In-Reply-To: <200607281658.37794.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281623.55290.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 15:58, Al Boldi wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> > > Rafael J. Wysocki wrote:
> > > > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > > > > swsusp is really great, most of the time.  But sometimes it hangs
> > > > > after coming out of STR.  I suspect it's got something to do with
> > > > > display access, as this problem seems hw related.  So I removed the
> > > > > display card, and it positively does not resume from ram on 2.6.16+.
> > > > >
> > > > > Any easy fix for this?
> > > >
> > > > I have one idea, but you'll need a patch to test.  I'll try to prepare
> > > > it tomorrow.
> > > >
> > > > I guess your box is an i386?
> > >
> > > That should be assumed by default :)
> >
> > I had hoped I would be able to test it somewhere, but I couldn't.  I hope
> > it will compile. :-)
> >
> > If it does, please send me the output of dmesg after a fresh boot.
> 
> See attached.  patched against 2.6.17.

Well, the nosave ranges are the same in both cases, so it doesn't look
very promising.

Have you tried to suspend with the patch applied?

Rafael
