Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVBAAkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVBAAkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVBAAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:33:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:61589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261485AbVBAAZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:25:07 -0500
Date: Mon, 31 Jan 2005 16:15:18 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: export the vfs release call of binary attribute
Message-ID: <20050201001518.GC7498@kroah.com>
References: <20050127201923.GA4968@vrfy.org> <20050127203410.GA5022@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127203410.GA5022@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:34:10PM +0100, Kay Sievers wrote:
> On Thu, Jan 27, 2005 at 09:19:23PM +0100, Kay Sievers wrote:
> > Initialize the allocated bin_attribute structure, otherwise unused fields
> > are pointing to random places.
> 
> Sorry, wrong place for the inititalization.
> 
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

Applied, thanks.

greg k-h
