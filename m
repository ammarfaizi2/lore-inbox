Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267023AbUBRNna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267055AbUBRNna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:43:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267023AbUBRNnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:43:17 -0500
Date: Wed, 18 Feb 2004 13:45:58 +0000
From: Joe Thornber <thornber@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-ID: <20040218134558.GN27549@reti>
References: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel> <p73wu6k653f.fsf@verdi.suse.de> <20040218025549.4e7c56a1.akpm@osdl.org> <20040219073734.309e396d.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219073734.309e396d.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:37:34AM +0100, Andi Kleen wrote:
> Supporting metadata can be quite simple - e.g. a standard header on the first blocks that
> has a length and a number of records with unique IDs. And the kernel driver would need
> to skip over these headers.

The target already takes an offset into the device, so you have what you want.

- Joe
