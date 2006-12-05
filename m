Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWLETyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWLETyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030815AbWLETyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:54:40 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:46558 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030621AbWLETyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:54:38 -0500
Date: Tue, 5 Dec 2006 20:52:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan Beulich <jbeulich@novell.com>
cc: Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fully support linker generated .eh_frame_hdr section
In-Reply-To: <45753A9C.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.61.0612052052230.18570@yvahk01.tjqt.qr>
References: <4574598F.76E4.0078.0@novell.com> <20061204145827.155ce33c.randy.dunlap@oracle.com>
 <45753A9C.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Now that binutils' ld is able to properly populate .eh_frame_hdr in the
>>> Linux kernel case, here's a patch to add some functionality to the Dwarf2
>>> unwinder to actually be able to make use of this (applies on firstfloor
>>> tree with the previously sent patch to add debug output, but not on plain
>>> 2.6.19).
>>
>>Requires what version of binutils / ld?
>
>mainline - the second of the required patches went in just yesterday.

Which means people using distros will have it in some 6 months, unless 
vendors give an earlier update.


	-`J'
-- 
