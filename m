Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWGYQhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWGYQhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWGYQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:37:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46056 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S964791AbWGYQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:37:03 -0400
Subject: Re: tighten ATA kconfig dependancies
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060715053418.GA5557@redhat.com>
References: <20060715053418.GA5557@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 04:05:02 +0100
Message-Id: <1153710303.2380.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> A lot of prehistoric junk shows up on x86-64 configs.

This is the old IDE layer, this isn't a bugfix or urgent so it isnt
appropriate for merging. It also makes testing and building more awkward
for maintainers.

This is the same policy we follow elsewhere in the kernel, filter stuff
that can't compile not general PCI stuff.

NAK


