Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRLAEpw>; Fri, 30 Nov 2001 23:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283916AbRLAEpc>; Fri, 30 Nov 2001 23:45:32 -0500
Received: from [193.252.19.61] ([193.252.19.61]:4585 "EHLO mel-rta7.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S281463AbRLAEp1>;
	Fri, 30 Nov 2001 23:45:27 -0500
Message-ID: <3C085FF3.813BAA57@wanadoo.fr>
Date: Sat, 01 Dec 2001 05:43:31 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre5 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre5 not easy to boot with devfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see,

when CONFIG_DEBUG_KERNEL is set
  and 
when devfsd is started at boot time
I get an Oops when remounting, rw the root fs :

Unable to handle kernel request at va 5a5a5a5e
...
EIP: 0010:[<c01516f9>] Not tainted
...
Process devfsd(pid:15,stackpage=cfd33000)
...

It boots OK with devfsd when CONFIG_DEBUG_KERNEL is not set.
It boots OK without devfsd when CONFIG_DEBUG_KERNEL is set (then devfsd
can be started after login).

PIII 650 256Mb devfsd-v1.3.20

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
