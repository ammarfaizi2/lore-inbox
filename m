Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTFVWTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTFVWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:19:32 -0400
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:60678 "EHLO mail4.kc.rr.com")
	by vger.kernel.org with ESMTP id S262285AbTFVWTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:19:32 -0400
Date: Sun, 22 Jun 2003 17:33:36 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Matti Rendahl <matti@comedialabs.com>
Subject: Re: memory problem with 2.4.21 SMP on Dell Dimension 8300 (i875p chipset)
Message-ID: <20030622223336.GA1511@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Matti Rendahl <matti@comedialabs.com>
References: <20030616021059.GA1671@glitch.localdomain> <20030620012411.GA1532@glitch.localdomain> <1056092485.9391.41.camel@comedialabs.dyndns.info> <20030620215437.GB14880@glitch.localdomain> <20030620234825.GA1389@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620234825.GA1389@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 06:48:25PM -0500, Greg Norris wrote:
> The ACPI update does indeed squash this problem.  THANX!!!

Unfortunately I was mistaken... :-(  I had enabled CONFIG_ACPI_HT_ONLY,
and wasn't aware of the requirement for the "acpismp=force" kernel
parameter.
