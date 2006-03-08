Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWCHRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWCHRyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWCHRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:54:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:20969 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751638AbWCHRyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:54:36 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603080940130.5804@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603080817500.5481@schroedinger.engr.sgi.com>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <10414.1141839308@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603080940130.5804@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 17:59:43 +0000
Message-Id: <1141840783.7605.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i386 does not fully implement things like write barriers since they have 
> an implicit ordering of stores.

Except when they don't (PPro errata cases, and the explicit support for
this in the IDT Winchip)

