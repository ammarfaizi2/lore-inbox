Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUJFXgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUJFXgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbUJFXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:32:39 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:14861 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S269581AbUJFXZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:25:31 -0400
Date: Thu, 07 Oct 2004 08:25:51 +0900 (JST)
Message-Id: <20041007.082551.03458322.yoshfuji@linux-ipv6.org>
To: aebr@win.tue.nl
Cc: alan@lxorguk.ukuu.org.uk, davem@davemloft.net, martijn@entmoot.nl,
       joris@eljakim.nl, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041006221512.GE4523@pclin040.win.tue.nl>
References: <00f201c4abf1$0444c3e0$161b14ac@boromir>
	<1097094326.29871.9.camel@localhost.localdomain>
	<20041006221512.GE4523@pclin040.win.tue.nl>
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

In article <20041006221512.GE4523@pclin040.win.tue.nl> (at Thu, 7 Oct 2004 00:15:12 +0200), Andries Brouwer <aebr@win.tue.nl> says:

> (There may be many objections - maybe such a setup would break
> more user space programs. Or maybe there are more ways select
> is broken than just the "discarded because of bad checksum" way.
> But it seems too early to just say "too bad, our select is not
> the POSIX one".)

select() != pselect(). :-)

--yoshfuji
