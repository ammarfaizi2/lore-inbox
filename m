Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUDJRCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDJRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:02:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:29318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbUDJRCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:02:37 -0400
Date: Sat, 10 Apr 2004 10:01:48 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, tim@cyberelk.net
Subject: Re: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040410170148.GI1317@kroah.com>
References: <20040410135115.GA3612@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410135115.GA3612@penguin.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 03:51:15PM +0200, Marcel Sebek wrote:
> This patch adds class support to ppdev.c.
> 
> The module compiles and loads ok.

Looks good, but we really shoulnd't be duplicating the devfs
functionality here.  We should only show the devices that the system
really has present, instead of always showing all of the devices.  Care
to fix your patch up to implement this instead?

thanks,

greg k-h
