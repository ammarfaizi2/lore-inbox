Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWHPIoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWHPIoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWHPIoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:44:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61869 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751009AbWHPIoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:44:37 -0400
Date: Wed, 16 Aug 2006 01:43:54 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] [3/3] Support piping into commands in /proc/sys/kernel/core_pattern
Message-ID: <20060816084354.GF24139@kroah.com>
References: <20060814127.183332000@suse.de> <20060814112732.684D313BD9@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814112732.684D313BD9@wotan.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 01:27:32PM +0200, Andi Kleen wrote:
> 
> Using the infrastructure created in previous patches implement support
> to pipe core dumps into programs. 
> 
> This is done by overloading the existing core_pattern sysctl
> with a new syntax:
> 
> |program

Very nice, do you happen to have a program that can accept this kind of
input for crash dumps?  I'm guessing that the embedded people will
really want this functionality.

thanks,

greg k-h
