Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWBAQSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWBAQSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWBAQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:18:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964960AbWBAQSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:18:32 -0500
Date: Wed, 1 Feb 2006 11:18:25 -0500
From: Dave Jones <davej@redhat.com>
To: Thomas Renninger <mail@renninger.de>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: + cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch added to -mm tree
Message-ID: <20060201161825.GE5875@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Renninger <mail@renninger.de>, linux-kernel@vger.kernel.org,
	mm-commits@vger.kernel.org
References: <200601312112.k0VLCRdV031988@shell0.pdx.osdl.net> <20060131223115.GF29937@redhat.com> <43E0A55C.6020700@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0A55C.6020700@renninger.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 01:11:08PM +0100, Thomas Renninger wrote:
 > >Did your pull fail for some reason? 
 > >
 > >		Dave
 > 
 > I got this answer from Andrew, maybe he also picked up the patch
 > from cpufreq list?:
 > ____________
 > This generates 100% rejects against the current cpufreq tree.

Ah, that's because I changed the indentation slightly when I merged it.

 > The patch needs a (!policy->cur) check for some cpufreq drivers, shall I 
 > resend
 > the whole patch with this one added or is the "ontop" patch I answered to 
 > avuton@gmail.com (Subject: Re: [PATCH 2/2] Re: 2.6.16-rc1-mm4) enough?

The 'ontop' is enough probably (I'm having a 'heavy' email day, so I've not
got to it yet).

		Dave

