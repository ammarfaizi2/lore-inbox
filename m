Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWBFSWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWBFSWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBFSWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:22:20 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41707 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932270AbWBFSWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:22:19 -0500
Subject: Re: [PATCH] Revert serial 8250 console fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 18:24:10 +0000
Message-Id: <1139250251.10437.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 11:20 -0600, Kumar Gala wrote:
> Revert Alan's SMP related console race fix as it breaks on some embedded
> PowerPC's.

Please figure out why your hardware is misbehaving before you make a
mess of everyone elses stuff. I've seen nothing from you in the way of
register dumps when this occurs. You need to find out what is actually
happening on your board.

Alan

