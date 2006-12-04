Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967733AbWLDW5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967733AbWLDW5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967741AbWLDW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:57:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:48413 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967733AbWLDW5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:57:50 -0500
Date: Mon, 4 Dec 2006 14:58:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fully support linker generated .eh_frame_hdr section
Message-Id: <20061204145827.155ce33c.randy.dunlap@oracle.com>
In-Reply-To: <4574598F.76E4.0078.0@novell.com>
References: <4574598F.76E4.0078.0@novell.com>
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

On Mon, 04 Dec 2006 16:23:27 +0000 Jan Beulich wrote:

> Now that binutils' ld is able to properly populate .eh_frame_hdr in the
> Linux kernel case, here's a patch to add some functionality to the Dwarf2
> unwinder to actually be able to make use of this (applies on firstfloor
> tree with the previously sent patch to add debug output, but not on plain
> 2.6.19).

Requires what version of binutils / ld?

Thanks,
---
~Randy
