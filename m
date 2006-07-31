Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWGaUTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWGaUTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGaUTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:19:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:64153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWGaUTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:19:24 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: x86_64 compile spewing hundreds of warnings - started 2.6.15-git8
Date: Mon, 31 Jul 2006 22:19:04 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
References: <440748FD.8010806@google.com> <44CE2C61.4010809@google.com>
In-Reply-To: <44CE2C61.4010809@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312219.04303.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 18:14, Martin Bligh wrote:
> Martin Bligh wrote:
> > between 2.6.15-git7 and 2.6.15-git8 we started getting hundreds of 
> > compile warnings:
> > 
> > -git7: http://test.kernel.org/20295/debug/test.log.0
> > -git8: http://test.kernel.org/20402/debug/test.log.0
> > 
> > Warnings look like this:
> > 
> > include/asm/bitops.h: In function `load_elf32_binary':
> > include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> > register

Hmm, as far as I can see I do the same as i386 with these constraints.
Are you sure i386 doesn't warn either? 

-Andi
