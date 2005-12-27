Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVL0DGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVL0DGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVL0DGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:06:21 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:59282 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932200AbVL0DGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:06:20 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.14.5
Date: Tue, 27 Dec 2005 14:06:03 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
References: <20051227005327.GA21786@kroah.com>
In-Reply-To: <20051227005327.GA21786@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 16:53:27 -0800, Greg KH <gregkh@suse.de> wrote:

>We (the -stable team) are announcing the release of the 2.6.14.5 kernel.
>
>The diffstat and short summary of the fixes are below.
>
>I'll also be replying to this message with a copy of the patch between
>2.6.14.4 and 2.6.14.5, as it is small enough to do so.

netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
on this box) or 2.4.32 :(  Same ruleset as used for months.

Fails to recognise named chains with a useless error message:

"iptables: No chain/target/match by that name"

Grant.
