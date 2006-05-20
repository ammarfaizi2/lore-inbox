Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWETPqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWETPqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWETPqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:46:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48652 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751111AbWETPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:46:09 -0400
Date: Sat, 20 May 2006 16:45:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, ppisa4lists@pikron.com
Subject: Re: Was this really supposed to go in?
Message-ID: <20060520154558.GB16679@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org, ppisa4lists@pikron.com
References: <446F3788.8050105@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446F3788.8050105@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 05:36:40PM +0200, Pierre Ossman wrote:
> Commit 2c171bf13423dc5293188cea7f6c2da1720926e2 in Linus' tree seems
> strange. It includes more changes than Pavel's original patch, but with
> the same commit message.

They shouldn't have gone in - they were a change I was working on a few
days ago which I left in the git tree uncommitted.  Applying Pavel's
patch then committed them.

> Also, I think the extra changes are broken as we then would have two
> parameters that have that contain the same information, yet the do not
> have the same ranges.

It's part of transitioning the data transfers over to taking the byte
size instead of the log2 byte size.

Well, I can't do anything about it now - I'm going away for a couple
of weeks from tomorrow morning.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
