Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWFLABI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWFLABI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 20:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFLABI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 20:01:08 -0400
Received: from waste.org ([64.81.244.121]:52450 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751191AbWFLABG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 20:01:06 -0400
Date: Sun, 11 Jun 2006 18:51:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] x86 built-in command line
Message-ID: <20060611235101.GK24227@waste.org>
References: <20060611215530.GH24227@waste.org> <1150069241.3131.97.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150069241.3131.97.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 01:40:41AM +0200, Arjan van de Ven wrote:
> On Sun, 2006-06-11 at 16:55 -0500, Matt Mackall wrote:
> > This patch allows building in a kernel command line on x86 as is
> > possible on several other arches.
> 
> wouldn't it make more sense to allow the initramfs to set such arguments
> instead?

Huh?

Are you suggesting we go digging around in a gzipped initramfs image at
early command line parsing time? I can't really see how that would work. 

-- 
Mathematics is the supreme nostalgia of our time.
