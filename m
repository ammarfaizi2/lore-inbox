Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTGBUwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTGBUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:52:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:12948 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264498AbTGBUwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:52:06 -0400
Date: Wed, 2 Jul 2003 14:06:19 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030702210619.GA9362@kroah.com>
References: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 11:00:06PM +0200, Andries.Brouwer@cwi.nl wrote:
> 
> Now suppose one wants a large dev_t. Some people do.
> Then several steps are needed. One of these steps
> is the addition of the mknod64 system call.
> That is a nice small isolated step - part of the necessary
> user space interface. It can be done independently of any
> other steps. It was submitted, but is not in the present
> kernel. Why not? I do not recall anybody pointing out problems.

I was wondering what had happened here with this.  What is left to do to
finish full support?

thanks,

greg k-h
