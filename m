Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUJUCed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUJUCed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270599AbUJUCeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:34:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:14479 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269163AbUJUCcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:32:52 -0400
Date: Wed, 20 Oct 2004 19:13:29 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: remove (unneeded proto) that causes a warning w/o CONFIG_PM
Message-ID: <20041021021329.GA27812@kroah.com>
References: <20041020023803.GF8597@taniwha.stupidest.org> <20041020235056.GA16606@kroah.com> <20041021002935.GA13781@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021002935.GA13781@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 05:29:35PM -0700, Chris Wedgwood wrote:
> On Wed, Oct 20, 2004 at 04:50:56PM -0700, Greg KH wrote:
> 
> > Wait, this patch causes problems if CONFIG_PM is enabled.  Not applied.
> 
> does it?  the function is declared before it's called so it should be
> ok surely?

I get compiler warnings with your patch applied...
