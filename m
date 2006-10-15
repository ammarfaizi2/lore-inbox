Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWJONyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWJONyo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWJONyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 09:54:43 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:11978 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964827AbWJONym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 09:54:42 -0400
Date: Sun, 15 Oct 2006 07:54:41 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-ID: <20061015135441.GC22289@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx> <20061013214135.8fbc9f04.akpm@osdl.org> <20061014140249.GL11633@parisc-linux.org> <20061014134855.b66d7e65.akpm@osdl.org> <20061015032000.GP11633@parisc-linux.org> <20061014235359.6d65647d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014235359.6d65647d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 11:53:59PM -0700, Andrew Morton wrote:
> It seems to have stopped happening.  I don't know why.

Argh.  Possibly a mistake during the bisect procedure?

> gregkh-pci-pci-prevent-user-config-space-access-during-power-state-transitions.patch
> still breaks suspend though: http://userweb.kernel.org/~akpm/s5000349.jpg

I believe that; I was going to generate a new patch for that yesterday,
but got distracted trying to debug your other problem.  I'll put out a
new version of that patch later today.
