Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWGaQto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWGaQto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWGaQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:49:44 -0400
Received: from mail.teleformix.com ([12.15.20.75]:4224 "EHLO
	mail.teleformix.com") by vger.kernel.org with ESMTP
	id S1030240AbWGaQtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:49:43 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Dan Oglesby <doglesby@teleformix.com>
Reply-To: doglesby@teleformix.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20060731162224.GJ31121@lug-owl.de>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	 <20060731144736.GA1389@merlin.emma.line.org>
	 <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <20060731162224.GJ31121@lug-owl.de>
Content-Type: text/plain
Organization: Teleformix, LLC
Date: Mon, 31 Jul 2006 11:47:00 -0500
Message-Id: <1154364421.7964.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 18:22 +0200, Jan-Benedict Glaw wrote:
> On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> > A colleague of mine happened to create a ~300gb filesystem and started
> > to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
> > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> 
> So preparation work wasn't done.
> 
> MfG, JBG
> 

I'd agree with that statement.  The wrong filesystem was chosen at the
beginning of the project.

As someone who is currently planning to migrate ~100GB of stored mail to
the Maildirs format, it was pretty clear early on that EXT3 would not
cut it (from past and current experiences), and not just for the sake of
calculating inodes.

--Dan

