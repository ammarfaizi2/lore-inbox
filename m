Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTJGSZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJGSZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:25:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:61315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262673AbTJGSZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:25:38 -0400
Date: Tue, 7 Oct 2003 11:04:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/core/message.c: error getting string descriptor 0 (error=-110)
Message-ID: <20031007180456.GG1956@kroah.com>
References: <20031006003844.GA23136@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006003844.GA23136@washoe.rutgers.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 08:39:47PM -0400, Yaroslav Halchenko wrote:
> Dear developers,
> 
> Previousely I reported a problem on my vaio laptop: 'irq 9: nobody
> cared', and all the ideas seems didn't help me (besides reversing all
> changes of bk4-bk5 usb changes).
> 
> Now I've tried recent test6-bk7 and from the 1st sight everything
> worked: usb mouse came alive but then nothing else really worked, nor
> usb palm, neither usb camera. The only error I'm getting 
> 
> drivers/usb/core/message.c: error getting string descriptor 0 (error=-110)
> 
> more details in
> 
> http://www.onerussian.com/Linux/bugs/nousb
> 
> What it can be?

Can you enable usb debugging and try to do something with the palm or
camera (like plug them in?) and post the kernel log from that?

thanks,

greg k-h
