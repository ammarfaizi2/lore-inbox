Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVI2ULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVI2ULp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVI2ULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:11:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932191AbVI2ULn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:11:43 -0400
Date: Thu, 29 Sep 2005 16:11:27 -0400
From: Dave Jones <davej@redhat.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Message-ID: <20050929201127.GB31516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 09:07:29PM +0100, Anton Altaparmakov wrote:

 > > $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
 > > $ cd linux-2.6
 > > $ rsync -a --verbose --stats --progress \
 > >   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
 > >   .git/
 > > 
 > > Could be just..
 > > 
 > > $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
 > > $ cd linux-2.6
 > > $ git pull
 > 
 > That is not actually the same.  "git pull" for example will not download 
 > Linus' tags whilst the rsync would get everything.

Ah. I didn't know this. Thanks.
Hmm, it'd be nice to have a shorthand 'not have to type the url, pull everything'.
Something like 'git pull all'.

		Dave

