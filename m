Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSGXWbT>; Wed, 24 Jul 2002 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSGXWbT>; Wed, 24 Jul 2002 18:31:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317620AbSGXWbS>; Wed, 24 Jul 2002 18:31:18 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: CMIPCI
Date: Wed, 24 Jul 2002 22:34:14 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ahna16$akn$1@penguin.transmeta.com>
References: <20020724220223.GA761@the-penguin.otak.com>
X-Trace: palladium.transmeta.com 1027550041 16267 127.0.0.1 (24 Jul 2002 22:34:01 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Jul 2002 22:34:01 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020724220223.GA761@the-penguin.otak.com>,
Lawrence Walton  <lawrence@the-penguin.otak.com> wrote:
>Looks like CMIPCI does not compile right now.

For "'synchronize_irq()' used without args", you only need to add the
irq number as the argument, and it should work. Please test to verify,
and send in a patch..

		Linus
