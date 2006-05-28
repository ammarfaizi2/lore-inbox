Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWE1O4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWE1O4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWE1O4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 10:56:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750763AbWE1O4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 10:56:49 -0400
Date: Sun, 28 May 2006 10:56:40 -0400
From: Dave Jones <davej@redhat.com>
To: Rafa? Bilski <rafalbilski@interia.pl>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [ PATCH ] Longhaul - call suspend(PMSG_FREEZE) before and	resume() after
Message-ID: <20060528145639.GA2984@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rafa? Bilski <rafalbilski@interia.pl>, linux-kernel@vger.kernel.org,
	Dave Jones <davej@codemonkey.org.uk>
References: <44798B99.9070608@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44798B99.9070608@interia.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 01:38:01PM +0200, Rafa? Bilski wrote:

 > Datasheet for my C3 Nehemiah says that this processor don't have local 
 > APIC and is not SMP capable. I have assumed (based on original longhaul.c) 
 > that all VIA C3 are not SMP capable.

Nehemiah has a local APIC, and is SMP capable.
(Though boards are hard to come by, and longhaul.ko has never
 been tested on such a system)

		Dave

-- 
http://www.codemonkey.org.uk
