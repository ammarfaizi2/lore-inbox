Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJHSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJHSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUJHSlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:41:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:7859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264113AbUJHShB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:37:01 -0400
Date: Fri, 8 Oct 2004 11:36:39 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linus@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect against buggy drivers
Message-ID: <20041008183639.GC4842@kroah.com>
References: <1097254421.16787.27.camel@localhost.localdomain> <20041008171414.GA28001@kroah.com> <1097260045.16787.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097260045.16787.59.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 11:27:25AM -0700, Stephen Hemminger wrote:
> Here is a better fix (thanks Greg) that allows long names for character
> device objects.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Thanks, I'll add this to my trees, and send it to Linus after 2.6.9 is
out (no in-kernel modules need this, so it isn't a real rush.)

thanks again,

greg k-h
