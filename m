Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030828AbWI0Ux0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030828AbWI0Ux0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030826AbWI0Ux0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:53:26 -0400
Received: from colin.muc.de ([193.149.48.1]:37898 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030828AbWI0UxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:53:25 -0400
Date: 27 Sep 2006 22:53:23 +0200
Date: Wed, 27 Sep 2006 22:53:23 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: revised pda patches
Message-ID: <20060927205323.GA36261@muc.de>
References: <4518D273.2030103@goop.org> <20060927113136.GA80066@muc.de> <451AAE0A.4010704@goop.org> <20060927194619.GB80066@muc.de> <451ADD44.2030500@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451ADD44.2030500@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 01:21:24PM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >Yes I dropped all i386-pda-* patches earlier.
> >  
> 
> "i386-pda-asm-offsets" doesn't really have anything to do with the PDA 
> stuff; it's just a generic cleanup. It got posted as a prereq, but I 
> don't consider it part of the same patch series (locally it doesn't have 
> the i386-pda- prefix).

Ok I readded it now.

> 
> >Also BTW the result didn't boot. Ok will try with that old patch too.
> >  
> 
> How did it fail?

It hangs after "Checking if processor honors the WP bit ..." 
That was in qemu, didn't try it on a real box

-Andi
