Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUIXQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUIXQps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIXQpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:45:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:31659 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268965AbUIXQoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:44:09 -0400
Date: Fri, 24 Sep 2004 09:43:15 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Jean Delvare <khali@linux-fr.org>, sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adding .class field to struct i2c_client (was Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20040924164315.GA7475@kroah.com>
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org> <415067CB.1020101@linuxtv.org> <20040924000202.GO14868@kroah.com> <4153BD2A.8030407@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4153BD2A.8030407@linuxtv.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:22:34AM +0200, Michael Hunold wrote:
> Hi,
> 
> On 24.09.2004 02:02, Greg KH wrote:
> >On Tue, Sep 21, 2004 at 07:41:31PM +0200, Michael Hunold wrote:
> >
> >>Please have a look and tell me what you think. The big problem will be, 
> >>that we cannot test all configurations, so it's possible that some 
> >>devices won't be recognized anymore, because the .class entries don't 
> >>match.
> 
> >I like the patches.  If you get them in a state you like (and drop the
> >printk(), and use dev_dbg() instead), 
> 
> Ok.
> 
> >and send them 1 patch per file
> >with the Signed-off-by: line, I'll be glad to apply them.
> 
> I'll re-create them against 2.6.9-rc2-mm2.
> 
> Do you really mean one patch per file, ie. about 50 separate patches? (I 
> don't care, I simply write a script that splits them up)

Sorry, I ment one email per patch (you sent more than one patch in that
email.)

thanks,

greg k-h
