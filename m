Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUGFWPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUGFWPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUGFWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:15:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2715 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264635AbUGFWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:15:46 -0400
Date: Tue, 6 Jul 2004 17:15:36 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: jmerkey@galt.devicelogics.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Spinlock timeout
Message-Id: <20040706171536.7052fca4.moilanen@austin.ibm.com>
In-Reply-To: <20040706204314.GA16951@galt.devicelogics.com>
References: <20040706161627.00f51cb0.moilanen@austin.ibm.com>
	<20040706204314.GA16951@galt.devicelogics.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 14:43:14 -0600
jmerkey@galt.devicelogics.com wrote:

> 
> 
> You should also for the UP case of Linux keep a counter 
> and call BUG() when someone calls a spinlock twice rather than
> just push, cli, and pop interrupt flags.  Guess what, this
> allows you to catch most deadlock bugs with spinlocks 

Isn't this what CONFIG_DEBUG_SPINLOCK is for?

Thanks,
Jake
