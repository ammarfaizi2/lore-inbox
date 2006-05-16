Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWEPR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWEPR3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWEPR3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:29:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932164AbWEPR3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:29:22 -0400
Date: Tue, 16 May 2006 10:29:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, nathanbecker@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: USB 2.0 ehci failure with large amount of
 RAM (4GB) on x86_64
Message-Id: <20060516102903.8cf069cf.zaitcev@redhat.com>
In-Reply-To: <200605122132.41410.david-b@pacbell.net>
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	<200605061232.52303.david-b@pacbell.net>
	<2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
	<200605122132.41410.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 21:32:39 -0700, David Brownell <david-b@pacbell.net> wrote:

> Can you confirm that this patch also resolves your issue? [...]

I noticed that you added the mask inside the case while Nathan
added it outside. So, he did it for all nVidia silicon.

I would think it may be better if he tested your patch very
exactly on top of a clean kernel (e.g. make sure that his own
patch is not in the way), and also sent us the lspci output
with the chip revision numbers.

-- Pete
