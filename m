Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUBKGnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUBKGnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:43:52 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:24783 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263606AbUBKGnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:43:49 -0500
Message-ID: <4029CF24.1070307@osdl.org>
Date: Tue, 10 Feb 2004 22:43:48 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
References: <4029CB7E.4030003@swapped.cc>
In-Reply-To: <4029CB7E.4030003@swapped.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  +++ linux-2.6.2.hlist/lib/list.c    2004-02-10 13:03:08.000000000 -0800
> @@ -0,0 +1,10 @@
> +#include <linux/module.h>
> +#include <linux/list.h>
> +
> +/*
> + *    shared tail sentinel for hlists
> + */
> +struct hlist_node hlist_null;

Could this be const?
