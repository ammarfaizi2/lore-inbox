Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVCOUZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVCOUZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVCOUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:22:32 -0500
Received: from [62.206.217.67] ([62.206.217.67]:33504 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261477AbVCOUSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:18:53 -0500
Message-ID: <42374329.4030206@trash.net>
Date: Tue, 15 Mar 2005 21:18:49 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tribble <prat@rice.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export dev_get_flags in net/core/dev.c to fix missing
 symbols
References: <1110916582.27963.1.camel@localhost.localdomain>
In-Reply-To: <1110916582.27963.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tribble wrote:
> ChangeSet@1.2186, 2005-03-15 13:46:12-06:00, prat@prat.homelinux.net
>   Export dev_get_flags to fix missing symbols in ipv6.ko

The same patch is already in Linus' tree:

ChangeSet 1.2186, 2005/03/15 10:16:32-08:00, akpm@osdl.org

	[NET]: Need to export dev_get_flags() to modules.
	
	Signed-off-by: Andrew Morton <akpm@osdl.org>
	Signed-off-by: David S. Miller <davem@davemloft.net>

Funny, you even hit the same ChangeSet number :)

Regards
Patrick
