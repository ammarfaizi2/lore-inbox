Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWJ2VvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWJ2VvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWJ2VvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:51:13 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:24840 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1030359AbWJ2VvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:51:12 -0500
Subject: Re: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer
	parameter names, some code motion
From: Don Mullis <dwm@meer.net>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610291306.36148.ak@suse.de>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920728.17807.39.camel@localhost.localdomain>
	 <1162152071.23311.28.camel@localhost.localdomain>
	 <200610291306.36148.ak@suse.de>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 13:44:19 -0800
Message-Id: <1162158259.23311.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 13:06 -0800, Andi Kleen wrote:
> On Sunday 29 October 2006 12:01, Don Mullis wrote:
> > Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.
> >
> > Tested by build and boot.
> 
> What error does that fix?

The build aborts with:

  include/asm/desc.h: In function 'set_ldt':
  include/asm/desc.h:92: error: implicit declaration of function 'write_gdt_entry'

The patch is a follow-on to my earlier reply to "[PATCH 1/4]".

DM

