Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264690AbUDVVgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264690AbUDVVgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUDVVgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:36:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:42899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264690AbUDVVga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:36:30 -0400
Date: Thu, 22 Apr 2004 14:31:46 -0700
From: Greg KH <greg@kroah.com>
To: Romain Lievin <lkml@lievin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tiglusb: wrong timeout value
Message-ID: <20040422213146.GC1800@kroah.com>
References: <20040419085559.GA13904@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419085559.GA13904@lievin.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 10:55:59AM +0200, Romain Lievin wrote:
> Hi,
> 
> this patch (cumulative; 2.4 & 2.6) fixes another bug in the tiglusb
> driver. The formula used to calculate jiffies from timeout is wrong.
> The new formula is ok and takes care of integer computation/rounding.
> This is the same kind of bug than in the tipar char driver.

Applied to 2.6, thanks.

greg k-h
