Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVBTXn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVBTXn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 18:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVBTXn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 18:43:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45456 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262111AbVBTXnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 18:43:24 -0500
Date: Sun, 20 Feb 2005 18:43:21 -0500
From: Dave Jones <davej@redhat.com>
To: Kenton Groombridge <kgroombr@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: agpgart-via: probe fails with error -22
Message-ID: <20050220234321.GA11777@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kenton Groombridge <kgroombr@charter.net>,
	linux-kernel@vger.kernel.org
References: <4218DD92.4040802@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4218DD92.4040802@charter.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 01:57:22PM -0500, Kenton Groombridge wrote:
 > [1.]  PROBLEM: agpgart-via: probe fails with error -22
 > 
 > [2.]  When loading agpgart/agpgart-via the following occurs:
 > 
 > Linux agpgart interface v0.100 (c) Dave Jones
 > agpgart: Detected VIA KT400/KT400A/KT600 chipset
 > agpgart: Maximum main memory to use for agp memory: 816M
 > agpgart: unable to determine aperture size.
 > agpgart: agp_backend_initialize() failed.
 > agpgart-via: probe of 0000:00:00.0 failed with error -22

Can you send me the output of (as root)  lspci -xxx
Also, is there a setting in your BIOS for 'aperture size' ?
If so, what is it set to ?

		Dave
