Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWCQMCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWCQMCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWCQMCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:02:00 -0500
Received: from mail.gmx.de ([213.165.64.20]:46980 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750837AbWCQMB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:01:59 -0500
X-Authenticated: #14349625
Subject: Re: oops in ext3_discard_reservation()
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>
In-Reply-To: <20060317035127.4c70eed3.akpm@osdl.org>
References: <1142577177.7973.6.camel@homer>
	 <20060317035127.4c70eed3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 13:03:30 +0100
Message-Id: <1142597010.7945.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 03:51 -0800, Andrew Morton wrote:

> It died in rsv_is_empty(), accessing rsv->_rsv_end, because `block_i' has a
> value of 0x00010000.
> 
> Looks like a bitflip.    How good is that hardware?
> 

Solid as a rock to date fwtw.

	-Mike

