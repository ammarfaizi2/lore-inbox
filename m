Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUAYN03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 08:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUAYN03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 08:26:29 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:44181
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264275AbUAYN02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 08:26:28 -0500
Date: Sun, 25 Jan 2004 08:37:12 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Robert Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 dual xeon
Message-ID: <20040125083712.A9318@animx.eu.org>
References: <20040124203646.A8709@animx.eu.org> <1074995006.5246.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <1074995006.5246.1.camel@localhost>; from Robert Love on Sat, Jan 24, 2004 at 08:43:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I recently aquired a dual xeon system.  HT is enabled which shows up as 4
> > cpus.  I noticed that all interrupts are on CPU0.  Can anyone tell me why
> > this is?
> 
> The APIC needs to be programmed to deliver interrupts to certain
> processors.
> 
> In 2.6, this is done in user-space via a program called irqbalance:

Thanks, working great.  (Debian by the way)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
