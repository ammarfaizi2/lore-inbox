Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVCJPU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVCJPU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVCJPU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:20:56 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:27152 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262649AbVCJPUu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:20:50 -0500
Date: Thu, 10 Mar 2005 09:22:23 -0600 (CST)
Message-Id: <20050310.092223.73714211.yoshfuji@linux-ipv6.org>
To: lorenzo@gnu.org
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1110464202.9190.7.camel@localhost.localdomain>
References: <1110464202.9190.7.camel@localhost.localdomain>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1110464202.9190.7.camel@localhost.localdomain> (at Thu, 10 Mar 2005 15:16:42 +0100), Lorenzo Hernández García-Hierro <lorenzo@gnu.org> says:

> Ported feature from grSecurity that makes possible to add an ipaddr
> entry in each /proc/<pid> (/proc/<pid>/ipaddr), where the task originating
> IP address is stored, and subsequently made available (readable) by the process
> itself and also the root user with CAP_DAC_OVERRIDE capability (that can be managed
> by specific security models implementations like SELinux).
> Available also at http://pearls.tuxedo-es.org/patches/task-curr_ip.patch

Please don't.

You already can get this information via procfs; e.g. lsof does,
It does support IPv6 as well.

--yoshfuji
