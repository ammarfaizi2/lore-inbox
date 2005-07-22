Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGVJbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGVJbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGVJbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:31:41 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:8167 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261221AbVGVJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:31:40 -0400
Date: Fri, 22 Jul 2005 11:31:38 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
Message-Id: <20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <42E0B6E4.1030303@pobox.com>
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
	<42E0B6E4.1030303@pobox.com>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 22 Jul 2005 05:05:40 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Christoph Pleger wrote:
> > At last I found out that setting HIGHMEM support to 64 GB is the
> > problem. But is it really not possible to use more than 4GB on an
> > Opteron machine?
> 
> Build and boot a 64-bit kernel, not a 32-bit kernel.
> 
> There is no highmem option for the 64-bit kernel, because it doesn't 
> need one.

I have two questions:

1. Is it possible to compile a 64-bit kernel on a 32-bit machine (or at
least on a 64-bit machine with 32-bit software) and if yes, how can I do
that?
2. All other software on the machine is 32-bit software. Will that
software work with a 64-bit kernel?

Christoph
