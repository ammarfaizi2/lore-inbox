Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbTLKI7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTLKI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:59:31 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:23019 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S264574AbTLKI73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:59:29 -0500
Date: Thu, 11 Dec 2003 09:58:38 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 Oops in journal_try_to_free_buffers (fwd)
Message-ID: <20031211085838.GA22606@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312101043020.17481-100000@logos.cnet> <1071066108.1609.5.camel@troy.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071066108.1609.5.camel@troy.scot.redhat.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:21:50PM +0000, Stephen Tweedie wrote:
> 
> I've only had one repeatable ext3 problem recently that looked remotely
> like this, and in that case it turned out to be bad memory.  There was a
> bad ram module that just happened to reliably corrupt one specific bit
> in page->buffers in a couple of pages of the mem_map[], which produced
> exactly this effect.  Frank, could you try a memtest86 run just to
> eliminate that possibility?

memtest86 3.0 ran for >12 hours on this 500MHz PIII (128MB ram) but no error.

-- 
Frank
