Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUG2AdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUG2AdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUG2AaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:30:11 -0400
Received: from port-195-158-169-111.dynamic.qsc.de ([195.158.169.111]:13966
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S267376AbUG2A2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:28:44 -0400
Message-ID: <410844F2.3030503@trash.net>
Date: Thu, 29 Jul 2004 02:29:38 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040722 Debian/1.7.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Kiko Piris <kernel@pirispons.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: ipsec and/or netfilter problem
References: <20040728212823.GA19345@mortadelo.pirispons.net>
In-Reply-To: <20040728212823.GA19345@mortadelo.pirispons.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kiko Piris wrote:
> Hi,
> 
> I've set up ipsec in my home LAN, it works like a charm except for a
> little problem.
> 
> The problem is that the server sends the data to Internet without doing
> SNAT (checked with tcpdump) (the packets do not traverse the POSTROUTING
> chain in nat table, checked watching the pkts counters).
> 
> Anyone has any hint?

You could try the netfilter+ipsec patches in netfilter patch-o-matic-ng,
they should solve this problem, The current patches only apply to 2.6.6,
but I will update them next week

> 
> If this is not the right list to post this kind of things, where should
> I ask?

netfilter-devel@lists.netfilter.org

Regards
Patrick
