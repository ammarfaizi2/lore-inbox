Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVK1Pfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVK1Pfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVK1Pfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:35:52 -0500
Received: from sd291.sivit.org ([194.146.225.122]:46342 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1750781AbVK1Pfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:35:51 -0500
Date: Mon, 28 Nov 2005 16:35:49 +0100
From: Luc Saillard <luc@saillard.org>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [2.5.15-rc2] khubd eating all CPU upon trying to remove pwc driver
Message-ID: <20051128153549.GB22888@sd291.sivit.org>
References: <200511271406.11266.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511271406.11266.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 02:06:10PM -0500, Shawn Starr wrote:
> 
> Hi Greg, 
> 
> It appears while debugging camserv to add some features, if I kill camserv 
> prematurely, and try to unload the pwc driver I am unable to. 

which version are you using of pwc driver ? which kernel ? no usb hub ? I
don't understand very well the old code that use usb frames. I will try to
reproduce the bug at home.

Luc 
