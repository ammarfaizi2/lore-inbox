Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUASJvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 04:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUASJvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 04:51:06 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:61591 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264484AbUASJvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 04:51:03 -0500
Date: Mon, 19 Jan 2004 09:50:03 +0000
From: Dave Jones <davej@redhat.com>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
Message-ID: <20040119095003.GB8621@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ryan Reich <ryanr@uchicago.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 03:11:27PM -0600, Ryan Reich wrote:

 > (WW) RADEON(0): [agp] AGP not available
 > 
 > and finally,
 > 
 > (II) RADEON(0): Direct rendering disabled

Make sure you're loading both the agpgart module, *AND* the
relevant chipset driver for your board, ie via-agp, intel-agp or the like.

		Dave
