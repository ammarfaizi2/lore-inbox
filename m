Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTIVRBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263237AbTIVRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:01:18 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:38882
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263220AbTIVRBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:01:17 -0400
Message-ID: <3F6F2B46.2000703@trash.net>
Date: Mon, 22 Sep 2003 19:03:02 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: philippe.vivarelli@mindspeed.com
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: IPSEC-TUNNEL gives error messages: ip_finish_output: bad unowned
 skb = c5b619e0: PRE_ROUTING LOCAL_IN FORWARD POST_ROUTING
References: <OF73D4154E.C6C4D37F-ONC1256DA9.005340B9@nice.mindspeed.com>
In-Reply-To: <OF73D4154E.C6C4D37F-ONC1256DA9.005340B9@nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

philippe.vivarelli@mindspeed.com wrote:

>Does someone has already seen thes messages ?.
>

Please try the latest -bk or apply these two patches, there have been recent
changes which affect these messages:

ChangeSet 1.1283.2.5, 2003/09/11 16:46:44-07:00, laforge@netfilter.org

	[NETFILTER]: Clear nf_debug in ipsec tunnel case.

ChangeSet 1.1315.1.2, 2003/09/12 17:14:53-07:00, acme@conectiva.com.br

	[NETFILTER]: Fix typo in recent ip_input.c changes.

or just disable CONFIG_NETFILTER_DEBUG.


Regards,
Patrick


