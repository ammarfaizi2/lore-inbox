Return-Path: <linux-kernel-owner+w=401wt.eu-S964838AbWLMKjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWLMKjw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWLMKjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:39:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:38872 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661AbWLMKjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:39:51 -0500
X-Greylist: delayed 1533 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:39:51 EST
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: server don't accept ip-connections from linux
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <457FD55E.13765.202391D@dieter.ferdinand.gmx.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GuR7v-0002Ds-00@calista.eckenfels.net>
Date: Wed, 13 Dec 2006 11:14:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <457FD55E.13765.202391D@dieter.ferdinand.gmx.de> you wrote:
> i check the packets with an analyser and make some test. if i disable ecn 
> with "echo 0x0 > /proc/sys/net/ipv4/tcp_ecn" it works, with ecn enabled, it 
> don't work.

this is a problem on the remote site (old firewall software), nothing we
(linux kernel) can do about it. You might want to inform the owner of the
server about that.

Gruss
Bernd
