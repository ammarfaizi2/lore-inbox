Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbUKBQed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUKBQed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbUKBQ3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:29:05 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:13331 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261920AbUKBQ2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:28:34 -0500
Date: Wed, 03 Nov 2004 01:29:23 +0900 (JST)
Message-Id: <20041103.012923.102810732.yoshfuji@linux-ipv6.org>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 dead in -bk11
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4187A4E3.8010600@pobox.com>
References: <418781EF.7020100@pobox.com>
	<20041102.225343.06193184.yoshfuji@linux-ipv6.org>
	<4187A4E3.8010600@pobox.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4187A4E3.8010600@pobox.com> (at Tue, 02 Nov 2004 10:16:51 -0500), Jeff Garzik <jgarzik@pobox.com> says:

> > Please send me:
> >  % ifconfig -a
> >  % netstat -nr --inet6
:
> Done, see attached.
> 
> ipv6/working/* is 2.6.10-rc1-bk2, and ipv6/dead/* is 2.6.10-rc1-BK-current.

Okay, thanks.

So... I guess that kernel failed to add "default route" on receipt of RA.
Right?

Hmm..

--yoshfuji
