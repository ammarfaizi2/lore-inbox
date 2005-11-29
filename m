Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVK2FEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVK2FEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVK2FEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:04:43 -0500
Received: from thunk.org ([69.25.196.29]:6546 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750761AbVK2FEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:04:42 -0500
Date: Tue, 29 Nov 2005 00:04:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051129050439.GB22879@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051128125351.GE30589@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128125351.GE30589@marowsky-bree.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 01:53:51PM +0100, Lars Marowsky-Bree wrote:
> On 2005-11-21T11:19:59, J?rn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > o Merge of LVM and filesystem layer
> >   Not done.  This has some advantages, but also more complexity than
> >   seperate LVM and filesystem layers.  Might be considers "not worth
> >   it" for some years.
> 
> This is one of the cooler ideas IMHO. In effect, LVM is just a special
> case filesystem - huge blocksizes, few files, mostly no directories,
> exports block instead of character/streams "files".

This isn't actually a new idea, BTW.  Digital's advfs had storage
pools and the ability to have a single advfs filesystem spam multiple
filesystems, and to have multiple adv filesystems using storage pool,
something like ten years ago.  Something to keep in mind for those
people looking for prior art for any potential Sun patents covering
ZFS.... (not that I am giving legal advice, of course!)

						- Ted

