Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWDBUaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWDBUaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDBUaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 16:30:21 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58074
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932377AbWDBUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 16:30:20 -0400
Date: Sun, 2 Apr 2006 13:29:57 -0700
From: Greg KH <greg@kroah.com>
To: Mikkel Erup <mikkelerup@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: sdhci driver produces kernel oops on ejecting the card
Message-ID: <20060402202957.GB28614@kroah.com>
References: <20060402194821.74793.qmail@web52107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060402194821.74793.qmail@web52107.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 12:48:21PM -0700, Mikkel Erup wrote:
> Using the sdhci driver from 2.6.16*-mm on my thinkpad
> X40, which has a Ricoh Co Ltd R5C822 card reader the
> kernel oopses when I eject the card.
> I reported this bug at the sdhci-devel list and Pierre
> Ossman advised me to post the bug here with CC Andrew
> Morton as he might have an idea what's causing it.
> Pierre said he didn't think it's a problem with the
> sdhci driver. The oops occurs whether I apply the full
> 2.6.16*-mm patch set or only the sdhci patches. Using
> the standalone 0.11 sdhci driver patches with kernel
> 2.6.15 everything works fine. 
> So here is the log as well as my kernel .config.

Does the latest -git tree also have this problem?

thanks,

greg k-h
