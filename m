Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbUKQSE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbUKQSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUKQR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:27:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42469 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262415AbUKQRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:25:43 -0500
Subject: Re: Linux 2.6.9-ac9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411162137_MC3-1-8ED7-97B6@compuserve.com>
References: <200411162137_MC3-1-8ED7-97B6@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100708514.32698.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 16:21:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-17 at 02:32, Chuck Ebbert wrote:
> Alan Cox wrote:
> 
> >o      Linus moved the remap_page_range flag fixes     (Linus Torvalds)
> >       into the function. Now this has had some 
> >       testing do the same in -ac and shrink the
> >       diff a lot
> 
> 
>   Was there a reason you left 15 occurrences of "vma->vm_flags |= VM_IO"
> in your patch?  A quick look showed most were followed by remap_page_range().

Time to check them all and the size of the diff already

