Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUHWFZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUHWFZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 01:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUHWFZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 01:25:40 -0400
Received: from main.gmane.org ([80.91.224.249]:49359 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267362AbUHWFZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 01:25:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Trivial IPv6-for-Fedora HOWTO
Date: Mon, 23 Aug 2004 14:25:32 +0900
Message-ID: <cgbv4e$pd6$1@sea.gmane.org>
References: <4129236E.9020205@pobox.com> <E1Bz1ya-0006Vi-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <E1Bz1ya-0006Vi-00@calista.eckenfels.6bone.ka-ip.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <4129236E.9020205@pobox.com> you wrote:
> 
>>If you have an iptables ipv4 firewall, you'll want to
>>
>>F1) allow ipv6 tunnelled packets to pass through to ip6tables, by 
>>allowing protocol 41
>>
>>iptables -A block -p 41 -j ACCEPT
>>("block" is a custom chain on my firewall)
>>
>>F2) duplicate your ipv4 firewall rules for ipv6, using ip6tables.  Some 
>>things, like masquerade, are not applicable to ipv6.
> 
> 
> Note that you have to terminate the tunnel on your firewall in order to
> filter the encapsulated ipv6. This is important, since letting tunnel
> packets pass your firewall is a major security problem, otherwise.

And what exactly does this mean?

"terminate the tunnel on your firewall" ???

Would you enlighten me (and the list) how do you do that with ip{,6}tables?

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

