Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264501AbRFJFyf>; Sun, 10 Jun 2001 01:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264502AbRFJFyZ>; Sun, 10 Jun 2001 01:54:25 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32533 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264501AbRFJFyT>; Sun, 10 Jun 2001 01:54:19 -0400
Date: Sun, 10 Jun 2001 01:54:13 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <hofmang@ibm.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B22CEF9.6DEB1A66@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0106100151090.9384-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Andrew Morton wrote:

> There's a problem in some versions of `pump' where it gets
> confused and ends up spinning indefinitely.  If you're using
> pump could you please try the latest RPM?

I doubt it's related to pump: a few times I've seen the 3c59x driver drop
the first few transmit packets.  Try loading the driver as a module and
putting the whole modprobe ; ifconfig ; ping <somehost> set of commands
into a script and watch what happens.  This goes for all ethernet driver
writers.

		-ben

