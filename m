Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCZW1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCZW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:27:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:37569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261361AbUCZW1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:27:44 -0500
Date: Fri, 26 Mar 2004 14:26:21 -0800
From: Greg KH <greg@kroah.com>
To: Romain Lievin <romain@lievin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sebastien.bourdeauducq@laposte.net
Subject: Re: [PATCH] tipar char driver (divide by zero)
Message-ID: <20040326222621.GA29854@kroah.com>
References: <20040321212812.GA3658@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321212812.GA3658@lievin.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 10:28:12PM +0100, Romain Lievin wrote:
> Hi Greg,
> 
> A patch about the tipar.c char driver has been sent on lkml by Sebastien Bourdeau. It fixes a divide-by-zero error when we try to read/write data after setting the timeout to 0.
> 
> I got it to make a patch to apply against kernel 2.4 and 2.6.
> Please apply.

Thanks, I've applied the 2.6 version and will send it on.

greg k-h
