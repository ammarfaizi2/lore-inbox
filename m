Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTHARKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTHARKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:10:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3509 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S270753AbTHARKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:10:00 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nicolas Pitre <nico@cam.org>, John Bradford <john@grabjohn.com>
Subject: Re: Messing with Kconfig.
Date: Fri, 1 Aug 2003 13:12:19 -0400
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, <szepe@pinerecords.com>
References: <Pine.LNX.4.44.0308011112310.9934-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.44.0308011112310.9934-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011312.19045.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 11:27, Nicolas Pitre wrote:
> On Fri, 1 Aug 2003, John Bradford wrote:
> > > So I'm looking at menuconfig and contemplating rearranging the heck out
> > > of it
> >
> > Please don't.  This comes up from time to time on the mailing list,
> > and massive re-arrangements are usually a Bad Thing.
>
> Of course "massive" re-arrangements all at once have always been rejected,
> and we've seen obvious examples of that in the kernel build/config system
> area already.
>
> One should have learned, though, that small incremental changes can achieve
> similar results and are much more acceptable to the rest of the community.

And one has to go especially slow during -test.  And if a change doesn't get 
merged immediately, you have to maintain it until there's an opening.  And if 
somebody ever actually tells you WHY it's wrong, this is not criticism but an 
opportunity to FIX it (sometimes by dropping the change)...

> Nicolas

Rob
