Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUFBRdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUFBRdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUFBRdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:33:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:63196 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263714AbUFBRdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:33:10 -0400
Date: Wed, 2 Jun 2004 10:15:42 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: Todd Poynor <tpoynor@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-ID: <20040602171542.GL7829@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru> <40B7B659.9010507@mvista.com> <20040529121059.3789c355.zap@homelink.ru> <40BCE28A.1050601@mvista.com> <20040602010036.440fc5b4.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602010036.440fc5b4.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:00:36AM +0400, Andrew Zabolotny wrote:
> 
> In theory, if we would use the standard power interface, it could use the
> different levels of power saving, e.g. 0 - controller and LCD on, 1,2 - LCD
> off, controller on, 3,4 - both off.

Please use the standard power interface, and use the standard levels of
power state.  That's why we _have_ this driver model in the first
place...

> > So none of my objections are terribly crucial, and if Greg et al don't 
> > have a problem with device-class-specific PM interfaces that have 
> > different semantics and/or capabilities than those of the device 
> > power/state attributes then I don't have much of a problem with it 
> > either.  Just seems worthwhile to check whether there's improvements 
> > needed in the existing PM interfaces instead.

I do have a problem with device-class-specific PM interfaces that have
different semantics from the whole rest of the system.

> Well, the power interface under drivers/ is available for framebuffer.
> If it would handle it properly (the framebuffer drivers I've tried
> don't, alas)

Then they need to be fixed to do so.

thanks,

greg k-h
