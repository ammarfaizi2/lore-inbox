Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVAELQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVAELQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAELQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:16:37 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:25559 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S262324AbVAELQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:16:35 -0500
Date: Wed, 5 Jan 2005 12:16:32 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 50% CPU user usage but top doesn't list any CPU unfriendly task
Message-ID: <20050105111632.GA7664@hout.vanvergehaald.nl>
References: <5a2cf1f6050103134611114dbd@mail.gmail.com> <200501040851.23287.norbert-kernel@edusupport.nl> <5a2cf1f6050104024368eb1424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2cf1f6050104024368eb1424@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 11:43:39AM +0100, jerome lacoste wrote:
> On Tue, 4 Jan 2005 08:51:23 +0100, Norbert van Nobelen
> <norbert-kernel@edusupport.nl> wrote:
> > The load and the CPU useage are two separate things:
> > Load: Defined by a programmer on an estimate on which his program is running
> > 100% fulltime, thus consuming little or more CPU/IO.
> > The interesting program you mention is the VoIP application. Is this program
> > multithreaded and is every thread using a little bit of CPU? Than it quickly
> > adds up to the mentioned 40%. 
> 
> There are some threads in that app, not that many, and none show in
> the top listing (which displays at least 30 entries). So I don't think
> this sum scenario is valid.

The correct display of threaded processes in top should be fixed by
the combination of procps-3.2.4 and the linux-2.6.10 kernel.
This according to the text in the announcement of procps-3.2.4.
I didn't test it yet, though.

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
