Return-Path: <linux-kernel-owner+w=401wt.eu-S1161127AbWLUIJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWLUIJI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWLUIJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:09:08 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:54697 "EHLO
	liaag2ae.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161127AbWLUIJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:09:07 -0500
Date: Thu, 21 Dec 2006 03:05:24 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Aiee, killing interrupt handler!
To: Hawk Xu <hxunix@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612210308_MC3-1-D5D4-3329@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4587B2C5.9000703@gmail.com>

On Tue, 19 Dec 2006 17:37:09 +0800, Hawk Xu wrote:

> > You need to post the entire oops message, not just the last part.  It should
> > start with "BUG". And using a more recent kernel would be a good idea.
> >   
> 
> I'm sorry, but that's all we have now.  Our customer just sent us a 
> photo of the kernel panic screen.

They need to boot in 50-line vga mode then, so more can be seen.

> Our client also sent the /var/log/kernel file to us.  According to the 
> log file, everytime before kernel panic, there are some error messages.  
> The server encountered kernel panic three times, below are the error 
> messages before each time:

Those are normal when running buggy usermode code, but they should
never be able to affect the kernel.

-- 
MBTI: IXTP

