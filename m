Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVHEWYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVHEWYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVHEWYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:24:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263152AbVHEWWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:22:47 -0400
Date: Fri, 5 Aug 2005 18:22:37 -0400
From: Dave Jones <davej@redhat.com>
To: Stelian Pop <stelian@popies.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
Message-ID: <20050805222237.GQ2241@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stelian Pop <stelian@popies.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1123278912.8224.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123278912.8224.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:55:12PM +0200, Stelian Pop wrote:
 > handle_mm_fault changed from an inline function to a non-inline one
 > (__handle_mm_fault), which is not available to external kernel modules.
 > The patch below fixes this.
 > 
 > Stelian.
 > 
 > Export __handle_mm_fault to modules (called by the inlined handle_mm_fault function).

Which modules need this ?

		Dave

