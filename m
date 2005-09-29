Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVI2Vky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVI2Vky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbVI2Vkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:40:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030254AbVI2Vkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:40:52 -0400
Date: Thu, 29 Sep 2005 17:40:43 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Message-ID: <20050929214043.GE31516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk> <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org> <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 02:35:15PM -0700, Linus Torvalds wrote:
 > 
 > 
 > On Thu, 29 Sep 2005, Linus Torvalds wrote:
 > > 
 > > Gaah. Using a new pine version, and it is back to corrupting whitespace.
 > 
 > Ok, disabling "text flowing" seems to have fixed it. It still leaves empty 
 > spaces at the end of lines when doing normal word-wrapping in the editor 
 > (and then seems to use those empty spaces as a "marker" for flowing), but 
 > that's at least just a small silly detail.
 > 
 > So how about this patch now? With it you can do
 > 
 > 	git fetch --tags <linus-kernel-repo>
 > 
 > and it should fetch all my tags automatically.

Seems to work. I blew away git/refs/tags/v2.6.13*
and git fetch --tags fetched them all back just fine.

		Dave

