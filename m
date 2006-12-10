Return-Path: <linux-kernel-owner+w=401wt.eu-S1762466AbWLJUL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762466AbWLJUL4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762468AbWLJUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:11:56 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:48665 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762460AbWLJULz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:11:55 -0500
Date: Sun, 10 Dec 2006 12:12:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061210121242.25495e63.randy.dunlap@oracle.com>
In-Reply-To: <20061209014445.94322fc2.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<20061209013055.51b26226.randy.dunlap@oracle.com>
	<20061209014445.94322fc2.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 01:44:45 -0800 Andrew Morton wrote:

> On Sat, 9 Dec 2006 01:30:55 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > On Mon, 4 Dec 2006 20:40:24 -0800 Andrew Morton wrote:
> > 
> > > kconfig-new-function-bool-conf_get_changedvoid.patch
> > > kconfig-make-sym_change_count-static-let-it-be-altered-by-2-functions-only.patch
> > > kconfig-add-void-conf_set_changed_callbackvoid-fnvoid-use-it-in-qconfcc.patch
> > > kconfig-set-gconfs-save-widgets-sensitivity-according-to-configs-changed-state.patch
> > > pa-risc-fix-bogus-warnings-from-modpost.patch
> > > kconfig-refactoring-for-better-menu-nesting.patch
> > > kbuild-fix-rr-is-now-default.patch
> > > kbuild-dont-put-temp-files-in-the-source-tree.patch
> > > actually-delete-the-as-instr-ld-option-tmp-file.patch
> > > 
> > >  Sent to Sam, but Sam's presently busy.  I might need to make some kbuild
> > >  decisions..
> > 
> > <groan> /me digs thru 65 KB email.
> > 
> > 
> > I can/will help on some of these if you want it...
> > 
> 
> feel free.  I'm planning on going through the above, see which of then have
> a sufficiently high obviousness*urgency product.

I see that you merged a few (or one?) of these. (obvious ones)

My review didn't come up with much help, I'm afraid.  And you
already asked for help on the series-of-4 gui-config patches.


actually-delete-the-as-instr-ld-option-tmp-file.patch
	I couldn't find this patch.

pa-risc-fix-bogus-warnings-from-modpost.patch
	looks obvious w/ medium priority

I'm little help on the Makefile changes, sorry.

My -git15 build finds lots of Section mismatch problems with
.parainstructions.  These could be false reports that need a
change in modpost (section checker).  I'll look into that
later today.

---
~Randy
