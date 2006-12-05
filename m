Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937482AbWLEIWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937482AbWLEIWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937483AbWLEIWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:22:38 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17814
	"EHLO emea1-mh.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937482AbWLEIWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:22:37 -0500
Message-Id: <45753A9C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 05 Dec 2006 08:23:40 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fully support linker generated .eh_frame_hdr
	section
References: <4574598F.76E4.0078.0@novell.com>
 <20061204145827.155ce33c.randy.dunlap@oracle.com>
In-Reply-To: <20061204145827.155ce33c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Randy Dunlap <randy.dunlap@oracle.com> 04.12.06 23:58 >>>
>On Mon, 04 Dec 2006 16:23:27 +0000 Jan Beulich wrote:
>
>> Now that binutils' ld is able to properly populate .eh_frame_hdr in the
>> Linux kernel case, here's a patch to add some functionality to the Dwarf2
>> unwinder to actually be able to make use of this (applies on firstfloor
>> tree with the previously sent patch to add debug output, but not on plain
>> 2.6.19).
>
>Requires what version of binutils / ld?

mainline - the second of the required patches went in just yesterday.

Jan
