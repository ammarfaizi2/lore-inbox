Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWJDUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWJDUdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWJDUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:33:13 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:47779 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751082AbWJDUdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:33:13 -0400
Date: Wed, 4 Oct 2006 14:33:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       rdunlap@xenotime.net, gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061004203311.GI28596@parisc-linux.org>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org> <20061004202938.GF352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004202938.GF352@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 08:29:38PM +0000, Frederik Deweerdt wrote:
> I see. Just to be sure that I got the matter right, does the issue boils
> down to a choice between:

woah, woah, woah, you're getting yourself confused here.

You're looking at what the architectures do here.  We're not concerned
with that, we're concerned with what the device drivers do with whatever
value the architecture has stuck in pdev->irq.
