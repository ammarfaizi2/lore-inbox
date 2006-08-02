Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWHBQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWHBQOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWHBQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:14:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42387 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932080AbWHBQOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:14:21 -0400
Subject: Re: Re : sparsemem usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
In-Reply-To: <20060802153316.7813.qmail@web25813.mail.ukl.yahoo.com>
References: <20060802153316.7813.qmail@web25813.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 17:33:42 +0100
Message-Id: <1154536422.23655.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 15:33 +0000, ysgrifennodd moreau francis:
> > sections but nothing stops you marking most of the 2Mb section except
> > the 128K that exists as "in use"
> 
> ok. But it will make pfn_valid() return "valid" for page beyond the first 128 KB.
> Won't that result in bad impacts later ?

Mapping out parts of a section is quite normal - think about the 640K to
1Mb hole in PC memory space.

Alan

