Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUFJQqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUFJQqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUFJQqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:46:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:6631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261993AbUFJQqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:46:45 -0400
Date: Thu, 10 Jun 2004 09:45:41 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/usb/core/devio.c: user/kernel pointer bugs
Message-ID: <20040610164541.GA32577@kroah.com>
References: <1086820850.14179.104.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086820850.14179.104.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 03:40:50PM -0700, Robert T. Johnson wrote:
> Since ctrl is copied in from userspace, ctrl.data cannot safely be 
> dereferenced.  Let me know if you have any questions or if I've made
> a mistake.

Oops, I added this bug, sorry about that, good catch.

I've applied this to my trees, thanks.

greg k-h
