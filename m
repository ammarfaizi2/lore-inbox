Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVJWTsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVJWTsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVJWTsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 15:48:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:5335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750703AbVJWTsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 15:48:16 -0400
Date: Sun, 23 Oct 2005 12:47:19 -0700
From: Greg KH <greg@kroah.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, pavel@ucw.cz, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Message-ID: <20051023194718.GA6454@kroah.com>
References: <20051022231214.GA5847@us.ibm.com> <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051023143617.GA7961@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 07:36:18AM -0700, Paul E. McKenney wrote:
> +#include <linux/debugfs.h>

Not needed, as you don't make any debugfs calls.

thanks,

greg k-h
