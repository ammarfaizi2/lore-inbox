Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265460AbTFVCvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 22:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbTFVCvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 22:51:54 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:33775 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265460AbTFVCvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 22:51:54 -0400
Date: Sat, 21 Jun 2003 20:06:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: john@beyondhelp.co.nz
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd 2.4.2? ext3
Message-Id: <20030621200617.648c5ec2.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 03:05:58.0154 (UTC) FILETIME=[33FF6EA0:01C3386B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Duthie <john@beyondhelp.co.nz> wrote:
>
> 
> I don't think kswap should be doing this ....
> 
>     4 ?        Z      0:14 [kswapd] <defunct>

That means kswapd oopsed and then exitted.  It should be in the logs
somewhere.

