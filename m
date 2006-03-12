Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWCLN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWCLN6z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCLN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:58:54 -0500
Received: from stinky.trash.net ([213.144.137.162]:18391 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751490AbWCLN6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:58:54 -0500
Message-ID: <441428AD.3010902@trash.net>
Date: Sun, 12 Mar 2006 14:57:01 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?= 
	<yoshfuji@linux-ipv6.org>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Nearly complete kzalloc cleanup for net/ipv6
References: <200603112136.43553.ioe-lkml@rameria.de>
In-Reply-To: <200603112136.43553.ioe-lkml@rameria.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> From: Ingo Oeser <ioe-lkml@rameria.de>
> 
> Stupidly use kzalloc() instead of kmalloc()/memset() 
> everywhere where this is possible in net/ipv6/*.c . 
> 
> The netfilter part is NOT included, because Harald should see these, too.

Feel free to send netfilter patches to me.
