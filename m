Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbUKQCiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUKQCiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbUKQCiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:38:04 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:63112 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262143AbUKQCiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:38:01 -0500
Date: Tue, 16 Nov 2004 21:32:33 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac9
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411162137_MC3-1-8ED7-97B6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>o      Linus moved the remap_page_range flag fixes     (Linus Torvalds)
>       into the function. Now this has had some 
>       testing do the same in -ac and shrink the
>       diff a lot


  Was there a reason you left 15 occurrences of "vma->vm_flags |= VM_IO"
in your patch?  A quick look showed most were followed by remap_page_range().



--Chuck Ebbert  16-Nov-04  21:28:21
