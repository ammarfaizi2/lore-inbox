Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWH1Ird@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWH1Ird (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWH1Ird
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:47:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41162 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751305AbWH1Irc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:47:32 -0400
Subject: Re: linux on Intel D915GOM oops
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, henti@geekware.co.za
In-Reply-To: <p7364gddzdm.fsf@verdi.suse.de>
References: <20060828102149.26b05e8b@yoda.foad.za.net>
	 <1156754346.3034.167.camel@laptopd505.fenrus.org>
	 <p7364gddzdm.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 10:47:30 +0200
Message-Id: <1156754850.3034.169.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 10:43 +0200, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > this is the known bug where by default Linux uses the BIOS services for
> > PCI rather than the native method.
> 
> It's a BIOS bug if the PCI BIOS doesn't work, not a Linux bug.

it's a bios bug if it doesn't work.
it's a linux mistake to depend on the bios for this in the first place
(since other OSes don't use this afaik)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

