Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWF1WlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWF1WlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWF1WlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:41:01 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:21721 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751640AbWF1WlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:41:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 00:41:20 +0200
User-Agent: KMail/1.9.3
Cc: "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com> <200606282242.26072.nigel@suspend2.net>
In-Reply-To: <200606282242.26072.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606290041.20263.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 June 2006 14:42, Nigel Cunningham wrote:
> On Wednesday 28 June 2006 21:28, Rahul Karnik wrote:
> > On 6/27/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > Suspend2 is a
> > > reimplementation of swsusp, not a series of incremental modifications. It
> > > uses completely different methods for writing the image, storing the
> > > metadata and so on. Until recently, the only thing it shared with swsusp
> > > was the refrigerator and driver model calls, and even now the sharing of
> > > lowlevel code is only a tiny fraction of all that is done.
> >
> > This is something I don't understand. Why can you not submit patches
> > that simply do things like "change method for writing image" and
> > reduce the difference between suspend2 and mainline? It may be more
> > work, but I think you will find that incremental changes are a lot
> > easier for people to review and merge.
> 
> It's because it's all so interconnected.

But it does not have to be.  Please try to untangle it so that you can submit
it in smaller pieces, one piece at a time.  Otherwise you require someone
to review all of your code and understand it at once, which is a huge task
and I don't think there's anyone with time resources needed for doing this.

Greetings,
Rafael
