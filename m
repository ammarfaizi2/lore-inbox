Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRAXX4n>; Wed, 24 Jan 2001 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRAXX4e>; Wed, 24 Jan 2001 18:56:34 -0500
Received: from quechua.inka.de ([212.227.14.2]:13364 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129406AbRAXX4P>;
	Wed, 24 Jan 2001 18:56:15 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data available
Message-Id: <E14LZlt-00034J-00@sites.inka.de>
Date: Thu, 25 Jan 2001 00:56:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can someone explain what is nagle or pinpoint explanation :)

nagel's algorithm is used to "wait" with sending of small packets until more
data is available, because sending biger packets has less overhead.

greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
