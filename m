Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278837AbRJZS4M>; Fri, 26 Oct 2001 14:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278839AbRJZS4F>; Fri, 26 Oct 2001 14:56:05 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40563 "EHLO
	mjc.meridian.redhat.com") by vger.kernel.org with ESMTP
	id <S278837AbRJZSzy>; Fri, 26 Oct 2001 14:55:54 -0400
Date: Fri, 26 Oct 2001 14:56:24 -0400 (EDT)
From: Alex Larsson <alexl@redhat.com>
X-X-Sender: <alexl@mjc.meridian.redhat.com>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dnotify semantics
In-Reply-To: <20011026203109.A32245@devcon.net>
Message-ID: <Pine.LNX.4.33.0110261455130.10309-100000@mjc.meridian.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Andreas Ferber wrote:

> On Fri, Oct 26, 2001 at 12:16:28PM -0600, Andreas Dilger wrote:
> 
> > So, monitor the parent of the directory in question for attribute changes.
> 
> ... which is a little bit difficult if you want to monitor the root
> directory.

Which is what i said in my mail, if you read it.

It also adds a monitor to a possibly busy directory that could cause a lot 
of spurious events and corresponding stats.

/ Alex

