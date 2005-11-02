Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVKBX3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVKBX3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVKBX3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:29:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:35025 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030200AbVKBX3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:29:30 -0500
Date: Wed, 2 Nov 2005 13:59:12 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] driver model wakeup flags
Message-ID: <20051102215912.GL23247@kroah.com>
References: <11304810223093@kroah.com> <1130481022955@kroah.com> <20051029075540.GA2579@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029075540.GA2579@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 09:55:41AM +0200, Pavel Machek wrote:
> Hi!
> 
> >   * There's a writeable sysfs "wakeup" file, with one of two values:
> >       - "enabled", when the policy is to allow wakeup
> >       - "disabled", when the policy is not to allow it
> >       - "" if the device can't currently issue wakeups
> 
> Could we either get "not-supported" value here, or remove the file if it is not
> supported? Having empty file is ugly...

Sure, have a patch for this?  :)

thanks,

greg k-h
