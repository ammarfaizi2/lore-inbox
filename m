Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUD1UxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUD1UxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUD1UCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:02:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:31150 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261673AbUD1TJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:09:54 -0400
Date: Thu, 29 Apr 2004 00:37:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040428190749.GI4016@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040422145625.GA2116@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422145625.GA2116@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 04:56:25PM +0200, Martin Schwidefsky wrote:
> Hi Dipankar,
> here is my newest version of the timer patch. I picked up your
> suggestion to add idle_cpu_mask to sched.c. Anything else ?

Looks good except that I am wondering if idle_cpu_mask should
really be called nohz_cpu_mask. That is what it is, after all.

Thanks
Dipankar
