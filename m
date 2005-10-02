Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVJBAMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVJBAMB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 20:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVJBAMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 20:12:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:30956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750923AbVJBAMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 20:12:01 -0400
Date: Sat, 1 Oct 2005 17:11:37 -0700
From: Greg KH <greg@kroah.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051002001137.GA17583@kroah.com>
References: <20051001182056.GA1613@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001182056.GA1613@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 11:20:56AM -0700, Paul E. McKenney wrote:
> +The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
> +implementations.  It makes three /proc entries available, namely: rcutw,
> +rcutr, and rcuts.

Ick, why /proc entries, this has nothing to do with processes, right?
Please use debugfs instead, that is what it was created for.

thanks,

greg k-h
