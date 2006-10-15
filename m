Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWJORrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWJORrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWJORrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:47:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422641AbWJORrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:47:45 -0400
Date: Sun, 15 Oct 2006 10:47:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061015104738.28a9709d.akpm@osdl.org>
In-Reply-To: <20061015135441.GC22289@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061013214135.8fbc9f04.akpm@osdl.org>
	<20061014140249.GL11633@parisc-linux.org>
	<20061014134855.b66d7e65.akpm@osdl.org>
	<20061015032000.GP11633@parisc-linux.org>
	<20061014235359.6d65647d.akpm@osdl.org>
	<20061015135441.GC22289@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 07:54:41 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Sat, Oct 14, 2006 at 11:53:59PM -0700, Andrew Morton wrote:
> > It seems to have stopped happening.  I don't know why.
> 
> Argh.  Possibly a mistake during the bisect procedure?

I don't think so - I spent a lot of time fiddling with that because it was
so bizarre to have two patches each of which caused the same failure.

Something has changed, perhaps config: the failure is a bit different now
(happens earlier).

> > gregkh-pci-pci-prevent-user-config-space-access-during-power-state-transitions.patch
> > still breaks suspend though: http://userweb.kernel.org/~akpm/s5000349.jpg
> 
> I believe that; I was going to generate a new patch for that yesterday,
> but got distracted trying to debug your other problem.  I'll put out a
> new version of that patch later today.

ok..  Add plenty of debug printks to it.
