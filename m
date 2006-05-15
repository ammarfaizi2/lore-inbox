Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWEOWXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWEOWXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWEOWXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:23:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58319 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965036AbWEOWXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:23:37 -0400
Date: Tue, 16 May 2006 00:20:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Rohan Mutagi <rohan208@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netdump netpoll bug?
Message-ID: <20060515222001.GA27083@electric-eye.fr.zoreil.com>
References: <91740af30605151141j1241bd62q925cd7c1f858d75b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91740af30605151141j1241bd62q925cd7c1f858d75b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohan Mutagi <rohan208@gmail.com> :
> Every time my system panics and  my client is dumping the vmcore to
> the netdump-server, I get error "netpoll_start_netdump: called
> recursively. rebooting". and my client reboots. And I get a
> vmcore-incomplete file. I did a fresh install of Linux RHEL4-WS and
> still get the same problem. Any ideas how to proceed?

Disable netdump. It does its best but it can not catch every crash
reliably.

[...]
> also if this is the wrong place to post, I would appriciate it if i
> coudl know the right place to post this message?

netdev@vger.kernel.org

-- 
Ueimor
