Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265528AbVBEVxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbVBEVxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbVBEVxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:53:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265747AbVBEVxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:53:32 -0500
Date: Sat, 5 Feb 2005 16:53:30 -0500
From: Dave Jones <davej@redhat.com>
To: Axel Schmalowsky <schmalowsky@mglug.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE
Message-ID: <20050205215330.GA26100@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Axel Schmalowsky <schmalowsky@mglug.de>,
	linux-kernel@vger.kernel.org
References: <4204B1D2.9070609@mglug.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204B1D2.9070609@mglug.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 11:45:22AM +0000, Axel Schmalowsky wrote:
 > Hey,
 > 
 > Can anyone tell me if it is destruktive or does it cause lose of 
 > performance if I set up
 > L1_CACHE_SHIFT_MAX as well as CONFIG_X86_L1_CACHE_SHIFT to the value of 10?

This makes no sense. This define is for the cacheline size, not
the total size of the cache.

		Dave

