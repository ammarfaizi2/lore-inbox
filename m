Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284446AbRLEO7r>; Wed, 5 Dec 2001 09:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284449AbRLEO7b>; Wed, 5 Dec 2001 09:59:31 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:16367 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S284442AbRLEO7M>; Wed, 5 Dec 2001 09:59:12 -0500
Date: Wed, 5 Dec 2001 14:59:01 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kamil Iskra <kamil@science.uva.nl>, Mark Hahn <hahn@physics.mcmaster.ca>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Problems with APM suspend and ext3
Message-ID: <20011205145901.A11105@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10111291006380.20544-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.33.0111302355140.1582-100000@bubu.home> <3C081D47.C931377B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C081D47.C931377B@zip.com.au>; from akpm@zip.com.au on Fri, Nov 30, 2001 at 03:59:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 30, 2001 at 03:59:03PM -0800, Andrew Morton wrote:
> Kamil Iskra wrote:
> > 
> > I've long since known that the
> > suspends are not completely reliable, even with ext2, particularly if
> > there was some disk activity going to right before or during a suspend.
> 
> Yup.  It seems that your BIOS is being asked to suspend all devices
> while there is still disk IO being performed.  And it refuses to
> suspend because the disk is still active.

Yep.  I'd still like to know exactly what the circumstances around
this are: just what are the constraints which apm requires us to
observe for successful suspend?  I've never had a laptop fail to
suspend due to this sort of problem with ext3, so it's obviously
different from one apm implementation to the next.

Cheers,
 Stephen
