Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLHXkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLHXkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:40:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:11678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261929AbTLHXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:40:05 -0500
Date: Mon, 8 Dec 2003 15:35:19 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031208233519.GB31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312081536.26022.andrew@walrond.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
> Whats the general feeling about devfs now? I remember Christoph and others 
> making some nasty remarks about it 6months ago or so, but later noted 
> christoph doing some slashing and burning thereof.
> 
> Is it 'nice' yet? 

The kernel code is nicer, but is is marked OBSOLETE.  It also has
insolvalble race conditions that have been detailed many times here on
lkml in the past.  Please search the archives for more info.

thanks,

greg k-h
