Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVFOLFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVFOLFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFOLFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:05:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:46788 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261399AbVFOLFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:05:30 -0400
Subject: Re: slow directory listing
From: Vladimir Saveliev <vs@namesys.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: 7eggert@gmx.de,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613120520.GA26921@mtholyoke.edu>
References: <4dSQ6-1vz-27@gated-at.bofh.it> <4dTCx-2d8-21@gated-at.bofh.it>
	 <E1DgrkL-00029X-HW@be1.7eggert.dyndns.org>
	 <20050613120520.GA26921@mtholyoke.edu>
Content-Type: text/plain
Message-Id: <1118833522.3603.148.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 15 Jun 2005 15:05:22 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2005-06-13 at 16:05, Ron Peterson wrote:
> On Sat, Jun 11, 2005 at 12:12:52AM +0200, Bodo Eggert wrote:
> > Ron Peterson <rpeterso@mtholyoke.edu> wrote:
> > > On Fri, Jun 10, 2005 at 10:37:20AM -0400, rpeterso wrote:
> > 
> > >> I'm setting up a new mail server, and am testing/tweaking IO.  I have
> > >> two directories: /test/a which contains 750 mbox files totalling 8GB,
> > >> and /test/a2, which contains the exact same number of files, same names,
> > >> all zero length.
> > >> ...
> > >> The times taken to do a directory listing are significantly different.
> > > 

Which filesystem is used for /test?

> > > I've become more confused, if that's possible.  I was just editing some
> > > test script in emacs.  As part of the script creation process I used the
> > > M-! command to pipe the output of 'ls /test/a' into a buffer.  It
> > > snapped back almost instantly.
> > 
> > Try ls|cat and take a look at $LS_OPTIONS and $LS_COLORS. I suspect your
> > ls tries to use some magic on the files to determine the color.
> 
> ls was aliased to 'ls -F', it just took me a while to notice...

