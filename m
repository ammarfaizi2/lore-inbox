Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269491AbUI3U1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269491AbUI3U1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUI3U1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:27:07 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50835 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S269491AbUI3U1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:27:04 -0400
Date: Thu, 30 Sep 2004 22:26:55 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overcommit symbolic constants
Message-ID: <20040930202653.GA5532@apps.cwi.nl>
References: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl> <1096548791.19269.5.camel@localhost.localdomain> <20040930141905.GA4077@apps.cwi.nl> <1096550863.19487.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096550863.19487.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:27:44PM +0100, Alan Cox wrote:

> What might work (if you've not already tried it) is to make the initial
> stack something like 1 or 4Mbytes. Don't map the pages but install a vma
> of that size. That would pre-reserve address space and perhaps avoid
> this. I guess if that works then make it a /proc/sys tunable for
> guaranteed stack.

A good and simple idea.
Yes, works entirely satisfactorily in my first few tests.

Andries
