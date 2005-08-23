Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVHWLKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVHWLKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVHWLK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:10:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62222 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932123AbVHWLK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:10:28 -0400
Date: Tue, 23 Aug 2005 12:10:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
In-Reply-To: <43099FDF.6030504@fujitsu-siemens.com>
Message-ID: <Pine.LNX.4.61L.0508231204510.2422@blysk.ds.pg.gda.pl>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> 
 <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> 
 <20050812133248.GN8974@wotan.suse.de>  <42FCA97E.5010907@fujitsu-siemens.com>
  <42FCB86C.5040509@fujitsu-siemens.com>  <20050812145725.GD922@wotan.suse.de>
  <86802c44050812093774bf4816@mail.gmail.com>  <20050812164244.GC22901@wotan.suse.de>
 <86802c4405081210442b1bb840@mail.gmail.com> <43099FDF.6030504@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2005, Martin Wilck wrote:

> It's a scalable system where multiple boards may be combined. Anyway, I see
> nothing in the specs that says you must start counting CPUs from zero.

 Well, Intel's "Multiprocessor Specification" mandates that (see section 
3.6.1 and also the compliance list in Appendix C).  I does not mandate 
local APIC IDs to be consecutive though.

  Maciej
