Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUBKPsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUBKPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:48:50 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:34147 "EHLO
	mwinf0804.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265791AbUBKPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:48:48 -0500
Date: Wed, 11 Feb 2004 16:48:23 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH][2.6] Oprofile, fix nmi_timer_int detection
Message-ID: <20040211164823.GA307@zaniah>
References: <Pine.LNX.4.58.0402081603120.3370@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402081603120.3370@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Feb 2004 at 16:22 +0000, Zwane Mwaikambo wrote:

> The nmi_timer_int oprofile driver was enabling itself unconditionally if
> an SMP kernel was being used on a UP system without an IOAPIC.
> 
> Tested on a P5 using NMI timer int driver and UP system using timer int
> driver both running an SMP kernel.

hi, Andrew these patch are fine for me:

bug fix form nmi_timer_int:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107627563717267&q=raw

adding timer_int suport for ARM, people wanting to test it needs oprofile
from CVS:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107627563718724&q=raw

regards,
Phil
