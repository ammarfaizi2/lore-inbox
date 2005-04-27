Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVD0K67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVD0K67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVD0K67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:58:59 -0400
Received: from quechua.inka.de ([193.197.184.2]:27295 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261405AbVD0K66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:58:58 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050427091402.GA1904@vagabond>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DQkFr-00078A-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 27 Apr 2005 12:58:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050427091402.GA1904@vagabond> you wrote:
> The problem with implementing in userland, as was already said in the
> thread, is, that if some process does not use the library, it can
> completely mess it up. It is only safe in kernel.

Only if all process use the transacted API. There is no reason to fear that
some malicious user is messing with your DB files.

Greetings
Bernd
