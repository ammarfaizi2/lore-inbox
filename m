Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTHJMAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 08:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTHJMAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 08:00:36 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:23445 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263875AbTHJMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 08:00:35 -0400
Date: Sun, 10 Aug 2003 07:00:32 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3] Hyperthreading gone
Message-ID: <20030810120032.GA14437@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <87llu2bvxg.fsf@deneb.enyo.de> <20030809221706.GA2106@glitch.localdomain> <87oeyyc7u9.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oeyyc7u9.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 09:03:42AM +0200, Florian Weimer wrote:
> I didn't.  Previous experience (with some 2.5.x versions) indicates
> that Linux does not support full ACPI on this machine.  The
> documentation suggests that the command line option enables full ACPI,
> so I hesitate to do this.

According to the 2.6.0-test3 menuconfig help text, the parameter is
required when CPU Enumeration Only is selected, and enables only
limited ACPI support.  For whatever it's worth, that matches my
experience.


   CONFIG_ACPI_HT_ONLY:

   This option enables limited ACPI support -- just enough to
   enumerate processors from the ACPI Multiple APIC Description
   Table (MADT).  Note that ACPI supports both logical (e.g. Hyper-
   Threading) and physical processors, where the MultiProcessor
   Specification (MPS) table only supports physical processors. 

   Full ACPI support (CONFIG_ACPI) is preferred.  Use this option
   only if you wish to limit ACPI's role to processor enumeration. 

   In this configuration, ACPI defaults to off. It must be enabled
   on the command-line with the "acpismp=force" option. 
 
