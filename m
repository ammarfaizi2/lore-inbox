Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWHTXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWHTXNv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWHTXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:13:51 -0400
Received: from ns.suse.de ([195.135.220.2]:61069 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751794AbWHTXNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:13:50 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86-64 add missing PMU MSR definitions
Date: Mon, 21 Aug 2006 01:13:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060820214856.GD27542@frankl.hpl.hp.com>
In-Reply-To: <20060820214856.GD27542@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608210113.44984.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 23:48, Stephane Eranian wrote:
> Hello,
> 
> Here is a patch to add a couple of missing MSR definitions related
> to Performance monitoring for EM64T. A separate patch contains the
> i386 equivalent.
> 
> Changelog:
>         - add MSR definitions for IA32_PEBS_ENABLE and PEBS_MATRIX_VERT


The names seem somewhat mixed up.

I think I would prefer P4 and no IA32 prefixes for all of them.
(or does Core2 still have PEBS?)

-Andi
