Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTDJVZS (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTDJVZS (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:25:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38405 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264177AbTDJVZP (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:25:15 -0400
Date: Thu, 10 Apr 2003 22:36:55 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: John Weber <weber@nyc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
In-Reply-To: <3E95DF4A.7060203@nyc.rr.com>
Message-ID: <Pine.LNX.4.44.0304102231390.23050-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Please test. 
> 
> I get an oops on boot in function fb_set_var (called from 
> radeon_init_disp).  This might simply be because I don't have the same 
> version of fbmem.c (I had to apply that hunk of the patch by hand) 
> although I have source of 2.5.67.

Yipes. That driver shouldn't be calling fb_set_var from the low level 
driver. 
 
> Anyone else not able to apply all parts of the patch cleanly?
> Anyone else seeing this problem?

I just tested the patch and I'm regenerating it again just in case.
Its at the same spot. I just put it up. Give it a try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz



