Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269719AbUJAHNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269719AbUJAHNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269722AbUJAHNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:13:45 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:19073 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S269719AbUJAHNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:13:44 -0400
Date: Fri, 1 Oct 2004 09:13:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange 2.6.9-rc3 keyboard repeat behavior
Message-ID: <20041001071323.GA5779@ucw.cz>
References: <415C8D7F.3020505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415C8D7F.3020505@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 06:49:35PM -0400, Jeff Garzik wrote:
> 
> After booting into 2.6.9-rc3 release kernel, I am seeing strange and 
> annoying keyboard repeat behavior.
> 
> If I hold down a single key, while in X, the character will repeat at 
> the expected (2.6.9-rc2 and prior) rate... for 1 second.
> 
> After 1 second, the keyboard repeat rate slows to half or more.
> 
> Can we please fix this?  Config attached.

How does it behave on the console? The problem is that X generates its
own software autorepeat and ignores what the kernel feeds it. So I
suppose this might be more a gettimeofday or scheduling problem than one
with the input layer.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
