Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272356AbTHNQcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272415AbTHNQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:32:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54278 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272356AbTHNQcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:32:52 -0400
Date: Thu, 14 Aug 2003 17:32:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814173249.C332@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030814130810.A332@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>; from torvalds@osdl.org on Thu, Aug 14, 2003 at 09:19:17AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:19:17AM -0700, Linus Torvalds wrote:
> 
> On Thu, 14 Aug 2003, Russell King wrote:
> > 
> > After reviewing the /proc/kcore and kclist issues, I've decided that I'm
> > no longer prepared to even _think_ about supporting /proc/kcore on ARM -
> 
> I suspect we should just remove it altogether.
> 
> Does anybody actually _use_ /proc/kcore? It was one of those "cool 
> feature" things, but I certainly haven't ever used it myself except for 
> testing, and it's historically often been broken after various kernel 
> infrastructure updates, and people haven't complained..

I was thinking afterwards about a patch to allow /proc/kcore to be
entirely disabled and dropped out of the kernel - we already select
between a.out and ELF.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

