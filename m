Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUEVAGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUEVAGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUEVAFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:05:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:56781 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265014AbUEUXzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:55:20 -0400
Date: Fri, 21 May 2004 16:52:29 -0700
From: Greg KH <greg@kroah.com>
To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] [usb] bad: scheduling while atomic!
Message-ID: <20040521235229.GB13404@kroah.com>
References: <20040521224531.GA15538@sun1000.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521224531.GA15538@sun1000.pwr.wroc.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 12:45:31AM +0200, Pawel Dziekonski wrote:
> Hi,
> 
> vanilla 2.6.6, i'm trying to rmmod my adsl usb modem module.
> rmmod hangs. I can Control-C it, but is does not end - it takes 
> 100% of cpu.

That's not "vanilla" as that kernel does not have a eagle-usb driver in
it, right?  Try talking with the authors of that driver please about
fixing this problem.

thanks,

greg k-h
