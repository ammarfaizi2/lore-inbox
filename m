Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJOLRI>; Tue, 15 Oct 2002 07:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJOLRH>; Tue, 15 Oct 2002 07:17:07 -0400
Received: from thunk.org ([140.239.227.29]:41165 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262385AbSJOLRH>;
	Tue, 15 Oct 2002 07:17:07 -0400
Date: Tue, 15 Oct 2002 07:22:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Dax Kelson <dax@gurulabs.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Modern Ext3 for 2.2.21 (Playstation 2 Linux)?
Message-ID: <20021015112253.GA31190@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tomas Szepe <szepe@pinerecords.com>, Dax Kelson <dax@gurulabs.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1034665566.1944.9.camel@mentor> <20021015071415.GC507@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015071415.GC507@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 09:14:15AM +0200, Tomas Szepe wrote:
> > I have a Playstation 2 running Linux. Currently it runs the 2.2.21
> > kernel.
> > 
> > I would like to upgrade from ext2 to ext3.
> > 
> > Is there a modern port of ext3 for the 2.2 kernel?
> 
> ext3-0.0.7a is known to work flawlessly.

Err, I wouldn't go that far.  In particular, error handling in the
case of I/O errors, out-of-memory errors, etc. may not work completely
correctly with ext3-0.0.7a.

It would be possible to try to backport a more recent version of ext3
to the 2.2 kernel, but it would probably be less work to forward port
the necessary drivers, etc. for the Playstation 2 to 2.4 or 2.5.....

						- Ted
