Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLBRYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLBRYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:24:46 -0500
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:50603
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S261464AbTLBRYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:24:45 -0500
Message-ID: <3FCCCB02.5070203@trash.net>
Date: Tue, 02 Dec 2003 18:25:22 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Wilmer van der Gaast <lintux@lintux.cx>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
References: <20031202165653.GJ615@gaast.net>
In-Reply-To: <20031202165653.GJ615@gaast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilmer van der Gaast wrote:

>For security reasons, I upgraded to 2.4.23 last night. Now, suddenly, IP
>masquerading seems to be broken. When I use SNAT instead of
>masquerading, everything works.
>
>Unfortunately, I think it's hard to reproduce the problem. Right after
>booting .23 for the first time, everything seemed to be okay. The
>problems started just an hour ago, after having the server running for
>fifteen hours without any problems.
>
>Unfortunately there's not much more information I can provide. I can
>attach my iptables/rule/route file and keep my machine running in case
>anyone needs/wants more information. For now I'll just stick with SNAT.
>It works good enough for me.
>  
>

Can you check the ringbuffer for error messages ? What happens
to the packets when masquerading fails ?

Best regards,
Patrick

