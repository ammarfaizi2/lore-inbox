Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVLUQlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVLUQlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLUQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:41:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751111AbVLUQlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:41:13 -0500
Date: Wed, 21 Dec 2005 11:40:26 -0500
From: Dave Jones <davej@redhat.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on	x86_64 machines ?
Message-ID: <20051221164024.GB3459@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Folkert van Heusden <folkert@vanheusden.com>,
	Eric Dumazet <dada1@cosmosbay.com>, Ed Tomlinson <edt@aei.ca>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512210744.52559.edt@aei.ca> <20051221132046.GJ27831@vanheusden.com> <43A95ABF.1030309@cosmosbay.com> <20051221140901.GM27831@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221140901.GM27831@vanheusden.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 03:09:02PM +0100, Folkert van Heusden wrote:

 > > Your results are interesting : size-32 seems to use objects of size 64 !
 > > > size-32             1538   2714     64 <<HERE>>
 > > So I guess that size-32 cache could be avoided at least for EMT (I take you 
 > > run a 64 bits kernel ?)
 > 
 > I think I do yes:
 > Linux xxxxx 2.4.21-37.EL #1 SMP Wed Sep 7 13:32:18 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
 > It is a redhat 4 x64 system.

Looks more like RHEL3 judging from the kernel version.

		Dave

