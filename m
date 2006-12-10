Return-Path: <linux-kernel-owner+w=401wt.eu-S1759050AbWLJFKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050AbWLJFKA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 00:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759064AbWLJFKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 00:10:00 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:38940 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759067AbWLJFJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 00:09:59 -0500
Date: Sun, 10 Dec 2006 14:09:20 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
Message-ID: <20061210050920.GA19828@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Jeff Garzik <jeff@garzik.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain> <457A9F3B.6020009@garzik.org> <Pine.LNX.4.64.0612090706500.13654@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612090706500.13654@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 07:11:21AM -0500, Robert P. J. Day wrote:
> i'm far more interested in at least knowing what happens to patches
> once they enter the system, so i can plan on what kind of cleanup i
> can work on next.
> 
Trivial patches tend not to be a priority for most people, especially
during a period when people are gearing up for the close of the merge
window (unless they happen to fix a serious bug, in which case it's
another matter, and it should also be brought to -stable's attention).
Timing has a lot to do with expected feedback for these sorts of things.

trivial@kernel.org exists to handle the rest of the bits, where Adrian
has a tendency to queue up many trivial and related patches at once, and
sending out pull requests at a time where it will be less disruptive to
the rest of development. You might be better off simply CC'ing trivial@
on these patch submissions and routinely checking the trivial git tree to
see whether they've been queued or not.

However, if you're changing or reordering functionality that isn't an
obvious bugfix, you're still going to have to get an ack from the
maintainer.
