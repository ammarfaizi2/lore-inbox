Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWBRQAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWBRQAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWBRQAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17068 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751436AbWBRQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:33 -0500
Date: Sat, 18 Feb 2006 15:51:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] swsusp: fix breakage with swap on LVM
Message-ID: <20060218145112.GA5658@openzaurus.ucw.cz>
References: <20060216161300.0C667194045@smtp.etmail.cz> <200602162251.25298.rjw@sisk.pl> <200602162341.17090.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602162341.17090.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-02-06 23:41:16, Rafael J. Wysocki wrote:
> On Thursday 16 February 2006 22:51, Rafael J. Wysocki wrote:
> > On Thursday 16 February 2006 17:13, Pavel Machek wrote:
> > > -rc3 version looks ok, and we probably want it in asap. -mm
> > > version looks a bit long... --p
> > 
> > That's because it adds a new function + comment.
> > 
> > I think it's not a good idea to remake mm/swapfile.c:swap_type_of()
> > in a -rc3-like fashion, because it is called by the userland interface for
> > a different purpose and should not return non-error for the argument
> > being zero.
> 
> Well, alternatively I can change the userland interface. :-)

ACK.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

