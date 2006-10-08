Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWJHQUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWJHQUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWJHQUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:20:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41701 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751255AbWJHQUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:20:15 -0400
Date: Sun, 8 Oct 2006 17:20:10 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       jdike@addtoit.com, blaisorblade@yahoo.it
Subject: Re: [PATCH] um: irq changes break build
Message-ID: <20061008162010.GZ29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610061025260.29356@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610061025260.29356@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:26:12AM +0300, Pekka J Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Fixup broken UML build due to 7d12e780e003f93433d49ce78cfedf4b4c52adc5 "IRQ:
> Maintain regs pointer globally rather than passing to IRQ handlers".

This is not a fix.  You need to arrange for set_irq_regs() done at the
right points.
