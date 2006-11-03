Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753457AbWKCSoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbWKCSoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbWKCSoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:44:38 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:19723 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1753451AbWKCSoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:44:37 -0500
Date: Sat, 04 Nov 2006 03:47:26 +0900 (JST)
Message-Id: <20061104.034726.27678443.yoshfuji@linux-ipv6.org>
To: devzero@web.de
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: unregister_netdevice: waiting for eth0 to become free
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <01a501c6ff74$6fc52c80$962e8d52@aldipc>
References: <01a501c6ff74$6fc52c80$962e8d52@aldipc>
Organization: USAGI/WIDE Project
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

In article <01a501c6ff74$6fc52c80$962e8d52@aldipc> (at Fri, 3 Nov 2006 19:18:17 +0100), "roland" <devzero@web.de> says:

> vserver1:~ # rmmod ipv6
> ERROR: Module ipv6 is in use by ip6t_REJECT
> vserver1:~ # rmmod ip6t_REJECT
> ERROR: Module ip6t_REJECT is in use

The ipv6 module cannot be unloaded once it has been
loaded.

I'm not sure what is happened with vmware.

--yoshfuji
