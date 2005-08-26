Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVHZTnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVHZTnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVHZTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:43:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:30398 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030233AbVHZTnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:43:50 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125085141.18155.97.camel@betsy>
References: <1125069494.18155.27.camel@betsy>
	 <d120d500050826122768cd3612@mail.gmail.com>
	 <1125085141.18155.97.camel@betsy>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 15:43:49 -0400
Message-Id: <1125085429.18155.99.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 15:39 -0400, Robert Love wrote:

> > This is racy - 2 threads can try to do this simultaneously.
> 
> Fixed.  Thanks.

Actually, doesn't sysfs and/or the vfs layer serialize the two
simultaneous writes?

	Robert Love


