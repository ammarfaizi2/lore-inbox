Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTFASIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTFASIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:08:18 -0400
Received: from granite.he.net ([216.218.226.66]:54546 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264040AbTFASIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:08:15 -0400
Date: Sun, 1 Jun 2003 11:10:25 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5 patch] let USB_GADGET depend on USB
Message-ID: <20030601181025.GA26006@kroah.com>
References: <20030531221855.GM29425@fs.tum.de> <3ED93D30.4070704@pacbell.net> <20030601111303.GV29425@fs.tum.de> <3EDA0B4E.504@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDA0B4E.504@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 07:18:54AM -0700, David Brownell wrote:
> 
> As I had already said (in response to your email that reported
> that problem), the fix is to revert the recent changeset that
> links gadget code twice.  Here's a patch that undoes it.

Yeah, that was my fault, sorry.  I didn't see the main Makefile change
and thought that this had gotten lost in one of my merges.  I'll revert
it and send it off to Linus later on.

Sorry,

greg k-h
