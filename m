Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVKQUw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVKQUw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKQUw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:52:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964858AbVKQUw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:52:27 -0500
Date: Thu, 17 Nov 2005 15:51:56 -0500
From: Dave Jones <davej@redhat.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
Message-ID: <20051117205156.GH5772@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com> <20051117194102.GE5772@redhat.com> <20051117204617.GA10925@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117204617.GA10925@isilmar.linta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:46:17PM +0100, Dominik Brodowski wrote:

 > > Actually Dave Miller did the detective work on that one, I just
 > > rebuilt some packages, and spread the good word :)
 > 
 > My Samsung X05 requires vbetool to resume from suspend-to-ram properly. Up
 > to 2.6.14, vbetool-0.3 worked fine; the PageReserved patch broke this (as
 > reported). Also the new package by Dave {Miller,Jones} didn't help and does
 > not help, even with these new 11 patches.
 
Davem's initial analysis was on ddcprobe, it's possible that whilst the
code is the same in both projects, that vbetool's needs are different
enough to require a different patch.

		Dave

