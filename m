Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTLJPoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLJPoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:44:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:29056 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263587AbTLJPoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:44:11 -0500
Date: Wed, 10 Dec 2003 07:43:10 -0800
From: Greg KH <greg@kroah.com>
To: Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in kobject_get at lib/kobject.c:439
Message-ID: <20031210154310.GA7365@kroah.com>
References: <20031210004120.GB2196@kroah.com> <26919.1071028748@www41.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26919.1071028748@www41.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 04:59:08AM +0100, Svetoslav Slavtchev wrote:
> 
> but i'm still missing raw devices, pty*, pts

For raw devices, I have a patch around here somewhere.  It still needs
a bit of work...

For pty* you don't have raw /dev entries anymore, there's a filesystem
that is used for that, devpts.

thanks,

greg k-h
