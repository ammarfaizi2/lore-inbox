Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUIXAIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUIXAIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIXAD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:03:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:60848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267212AbUIXADr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:03:47 -0400
Date: Thu, 23 Sep 2004 17:02:02 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Jean Delvare <khali@linux-fr.org>, sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adding .class field to struct i2c_client (was Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20040924000202.GO14868@kroah.com>
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org> <415067CB.1020101@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415067CB.1020101@linuxtv.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 07:41:31PM +0200, Michael Hunold wrote:
> Please have a look and tell me what you think. The big problem will be, 
> that we cannot test all configurations, so it's possible that some 
> devices won't be recognized anymore, because the .class entries don't match.

I like the patches.  If you get them in a state you like (and drop the
printk(), and use dev_dbg() instead), and send them 1 patch per file
with the Signed-off-by: line, I'll be glad to apply them.

thanks,

greg k-h
