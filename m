Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVAFTvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVAFTvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVAFTtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:49:06 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:55266 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262974AbVAFTrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:47:21 -0500
Subject: Re: Problem with irqrouting and resume
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
In-Reply-To: <1103474172.4219.26.camel@localhost.localdomain>
References: <1103474172.4219.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 12:47:02 -0700
Message-Id: <1105040822.22985.29.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-19 at 17:36 +0100, Martin Josefsson wrote:
> I have a small problem with newer kernels on my laptop, an IBM X31.
> The problem is that the e1000 interface doesn't work after I've resumed
> from suspend to disk. This used to work fine until recently, not sure
> which kernel broke it. suspend-to-ram still works.

Can you try these patches please:

    http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0284.html
    http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0548.html

I suspect that they will fix the problem; let me know either way.

Thanks very much for testing this and reporting the problem!


