Return-Path: <linux-kernel-owner+w=401wt.eu-S1751723AbXAPWbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAPWbA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXAPWbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:31:00 -0500
Received: from farad.aurel32.net ([82.232.2.251]:2601 "EHLO mail.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbXAPWa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:30:59 -0500
X-Greylist: delayed 2885 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 17:30:59 EST
Message-ID: <45AD46DD.7050408@aurel32.net>
Date: Tue, 16 Jan 2007 22:42:53 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPv6 router advertisement broken on 2.6.20-rc5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have just tried a 2.6.20-rc5 kernel (I previously used a 2.6.19 one),
and I have noticed that the IPv6 router advertisement functionality is
broken. The interface is not attributed an IPv6 address anymore, despite
/proc/sys/net/ipv6/conf/all/ra_accept being set to 1 (also true for each
individual interface configuration).

Using tcpdump, I am seeing the router advertisement messages arriving on
the interface, but they seems to be ignored.

Does somebody have also seen this behaviour?

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
