Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKECSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKECSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUKECSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:18:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35494 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261669AbUKECSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:18:16 -0500
Message-ID: <418AE27D.6060609@pobox.com>
Date: Thu, 04 Nov 2004 21:16:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-2022-JP?B?WU9TSElGVUpJIEhpZGVha2kgLyAbJEI1SEYjMVFMQBsoQg==?= 
	<yoshfuji@linux-ipv6.org>
CC: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@osdl.org
Subject: Re: IPv6 dead in -bk11
References: <20041102.225343.06193184.yoshfuji@linux-ipv6.org>	<4187A4E3.8010600@pobox.com>	<20041103.012923.102810732.yoshfuji@linux-ipv6.org> <20041104.012128.51410945.yoshfuji@linux-ipv6.org>
In-Reply-To: <20041104.012128.51410945.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / 吉藤英明 wrote:
> Sorry, this bug was introduced by my changeset:
> <http://linux.bkbits.net:8080/linux-2.5/cset@417dca81tJ4RRAxhWTbn0p6hI-1XIQ>.
> 
> David, this should fix the issue.
> Please apply.
> 
> D: Don't purge default routes by RA.
> D:
> D: Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>


ACK.  This fixed my problem.

Thanks!

	Jeff


