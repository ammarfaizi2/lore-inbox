Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWJWRO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWJWRO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWJWRO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:14:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44508 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964965AbWJWROy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:14:54 -0400
Date: Mon, 23 Oct 2006 19:14:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ncunningham@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061023171450.GA3766@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023095522.e837ad89.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-10-23 09:55:22, Andrew Morton wrote:
> > On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > I'm trying to prepare the patches to make swsusp into suspend2.
> > 
> > Oh, I see.  Please don't do that.
> 
> Why not?

Last time I checked, suspend2 was 15000 lines of code, including its
own plugin system and special user-kernel protocol for drawing
progress bar (netlink based). It also did parts of user interface from
kernel.

OTOH, that was half a year ago, but given that uswsusp can now do most
of the stuff suspend2 does (and without that 15000 lines of code), I
do not think we want to do complete rewrite of swsusp now.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
