Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVJ3OWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVJ3OWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVJ3OWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:22:35 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:14598 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750995AbVJ3OWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:22:34 -0500
Date: Sun, 30 Oct 2005 10:15:06 -0500
From: Jeff Dike <jdike@addtoit.com>
To: jonathan@jonmasters.org
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: What's wrong with tmpfs?
Message-ID: <20051030151506.GA3354@ccure.user-mode-linux.org>
References: <200510300624.38794.rob@landley.net> <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:53:00PM +0000, Jon Masters wrote:
> On 10/30/05, Rob Landley <rob@landley.net> wrote:
> 
> > If somebody needs a reproduction sequence, I'm happy to oblige.  In theory
> > "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it
> > wouldn't have shipped...
> 
> I don't see this behaviour on a regular desktop box running 2.6.14.
> Guess it's UML specific.

Sorry, but wrong.

IIRC, this triggers when you don't have CONFIG_TMPFS enabled.  If you don't,
you still get it, but you get a version that's only usable in-kernel.

				Jeff
