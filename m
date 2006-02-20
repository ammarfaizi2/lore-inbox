Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWBTMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWBTMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWBTMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:31:28 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:38405 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030184AbWBTMb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:31:27 -0500
Date: Mon, 20 Feb 2006 13:31:22 +0100
From: Olivier Galibert <galibert@pobox.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220123122.GA6086@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430269.3429.8.camel@mindpipe> <200602202041.02085.nigel@suspend2.net> <1140437152.3429.20.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140437152.3429.20.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 07:05:52AM -0500, Lee Revell wrote:
> My point was simply that "we need this now" is not a good argument for
> immediate merging - I was not trying to imply that you aren't working
> fast enough ;-)

What about "we need this two years ago" ?

I'm having a really hard time convincing myself that Pavel and
friends, while rather good as developpers, haven't succumbed to a bad
case of NIH syndrome.  Even with wanting to move as many things to
userspace as possible, merging suspend2 with cleanups if necessary,
_then_ starting from there to move things to userspace seems more
realistic long-term.  Right now it really looks like they're only
trying to redo what's already in suspend2, tested and debugged, only
different and new, hence untested and undebugged.

The only thing I've seen that is really against suspend2 is the amount
of code it adds to the kernel.  Given that said code is actively
maintained, moving what can be moved to userspace can easily be done
afterwards.

  OG.
