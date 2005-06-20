Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVFUAFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVFUAFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVFUADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:16 -0400
Received: from [62.206.217.67] ([62.206.217.67]:20653 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261792AbVFTXjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:39:31 -0400
Message-ID: <42B753A8.5050808@trash.net>
Date: Tue, 21 Jun 2005 01:39:20 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: iptables bug
References: <20050619233029.45dd66b8.akpm@osdl.org>	<1119305756l.1344l.0l@werewolf.able.es> <20050620153445.5daaed4e.akpm@osdl.org>
In-Reply-To: <20050620153445.5daaed4e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> 
>>Are there any known problems with iptables ?

No known problems.

>>I see strange things.
>>When I use bittorrent (azureus or bittorrent-gui), at the same time as
>>iptables (for nat and internet access for my ibook), when I stop a download
>>or exit from one of this apps my external network goes down. 
>>I have tried the same without iptables loaded and it works fine.

What exactly do you mean with "network goes down"? Can you find out
where the packets disappear? Do they silently disappear, or do you get
an error code from sendmsg? What about received packets?

Regards
Patrick
