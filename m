Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVDGIwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVDGIwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVDGIwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:52:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:36500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbVDGIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:52:19 -0400
Date: Thu, 7 Apr 2005 01:51:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Out of memory with Java 1.5 and 2.6.11.6
Message-ID: <20050407085159.GU28536@shell0.pdx.osdl.net>
References: <200504062131.36204.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504062131.36204.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robin Rosenberg (robin.rosenberg.lists@dewire.com) wrote:
> 
> I see regular crashes with 2.6.11.6 (mandrake-patched) and Java 1.5.02 (01 too
> btw, but not 1.4.2). Gentoo people report the same problem sugesting that it
> may have appeared between 2.6.11.4 and 2.6.11.5.

Sounds very unlikely, we didn't change anything in -stable that would
trigger.

Any chance 

# echo 1 >  /proc/sys/vm/legacy_va_layout

makes any difference?  I've seen this once before (apparently with old
glibc threading library as well).

thanks,
-chris
