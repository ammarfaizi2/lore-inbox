Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbULZSnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbULZSnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbULZSnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:43:51 -0500
Received: from [62.206.217.67] ([62.206.217.67]:19134 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261729AbULZSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:43:50 -0500
Message-ID: <41CF062E.5090407@trash.net>
Date: Sun, 26 Dec 2004 19:42:54 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lists@naasa.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10 with IPSEC problems?
References: <200412261553.24178.lists@naasa.net> <41CEDB2B.7080309@trash.net> <200412261915.26681.lists@naasa.net>
In-Reply-To: <200412261915.26681.lists@naasa.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Platte wrote:
> Thanks for the fast reply. It solved my problem. Is this change somewhere 
> documented? Where can I get this kind of information, if I have problems in 
> the future with the kernel IPSEC implementation?

The change was discussed on netdev before it went in. The
old behaviour was a security problem, so this change, which
breaks tunnel setups without forward policies, had to be
made. This will hopefully not happen again, but if you have
problems with IPsec and suspect a kernel bug, write to
netdev@oss.sgi.com.

Regards
Patrick
