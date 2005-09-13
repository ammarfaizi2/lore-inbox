Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVIMAI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVIMAI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVIMAI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:08:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbVIMAI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:08:58 -0400
Date: Mon, 12 Sep 2005 17:08:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-Id: <20050912170852.17579ed5.akpm@osdl.org>
In-Reply-To: <210290000.1126565170@flay>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<201750000.1126494444@[10.10.2.4]>
	<20050912050122.GA3830@muc.de>
	<150330000.1126548402@flay>
	<20050912185120.GA78614@muc.de>
	<210290000.1126565170@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> 
> 
> --On Monday, September 12, 2005 20:51:20 +0200 Andi Kleen <ak@muc.de> wrote:
> 
> >> Crashes on boot
> >> 
> >> http://test.kernel.org/12589/debug/console.log
> >> 
> >> May or may not be anything to do with what you were doing.
> > 
> > Easily tested by reverting dma32*. Does it help?
> 
> No. Yet *another* bug. Sigh.
> 

You should see all the ones I fixed.

Suggest you skip -mm2 altogether.  We already know that
scheduler-cache-hot-autodetect.patch is bad, and that was dropped from mm3.

