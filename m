Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKWPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKWPSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUKWPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:18:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:56246 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261302AbUKWPSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:18:10 -0500
Date: Tue, 23 Nov 2004 07:17:47 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Message-ID: <20041123151747.GA26986@kroah.com>
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com> <20041122714.9zlcKGKvXlpga8EP@topspin.com> <20041122225033.GD15634@kroah.com> <52ekil9v1m.fsf@topspin.com> <20041123063045.GA22493@kroah.com> <52llct83o1.fsf@topspin.com> <20041123074337.GB23194@kroah.com> <523bz08v1c.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523bz08v1c.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 07:06:07AM -0800, Roland Dreier wrote:
>     Greg> Yes, it probably should be.  Hm, no, we don't allow you to
>     Greg> put class specific files if you use the class_simple API,
>     Greg> sorry I misread your question.  You can just handle the
>     Greg> class yourself and use the CLASS_ATTR() macro to define your
>     Greg> api version function.
> 
> Ugh, then we end up duplicating the class_simple code.  Would you
> accept a patch that adds class_simple_create_file()/class_simple_remove_file()?

Ick, ok, sure.  Just make sure to mark them as EXPORT_SYMBOL_GPL() :)

thanks,

greg k-h
