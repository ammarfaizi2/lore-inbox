Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUEFLs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUEFLs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUEFLs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:48:56 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:6547 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261787AbUEFLsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:48:54 -0400
Date: Thu, 6 May 2004 12:47:59 +0100
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] DMI cleanup patches
Message-ID: <20040506114759.GA27851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040506102904.GA3295@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506102904.GA3295@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 02:29:04PM +0400, Andrey Panin wrote:

Hi Andrey,

 > currently arch/i386/kernel/dmi_scan.c file looks like complete
 > mess. Interfacing with other kernel subsystem made using
 > ad-hoc ways, mostly with ugly global variables, additionaly
 > coding style is ... not good. So these patches appear:

Very nice! I like the idea of moving bits to the actual drivers
a lot. It makes perfect sense to have apm workarounds in the
apm driver etc.

One thing that might be worth your while whilst you're getting
intimate with this code, would be to take a peek at the dmi
workarounds in 2.4 and make sure we didn't miss any.
I forward ported a bunch a few months back, but I'm not sure
if I got them all, and it's possible new ones were added there
that we missed in 2.6

Good work.

		Dave

