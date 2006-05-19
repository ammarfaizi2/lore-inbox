Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWESHpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWESHpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 03:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWESHpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 03:45:39 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:25797 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S932117AbWESHpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 03:45:38 -0400
X-OB-Received: from unknown (192.168.9.232)
  by 192.168.8.90; 19 May 2006 07:45:36 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Penshoppe Estrada" <penshoppe@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 19 May 2006 15:45:36 +0800
Subject: Kernel compile Error
X-Originating-Ip: 203.177.104.33
X-Originating-Server: ws5-11.us4.outblaze.com
Message-Id: <20060519074536.95542CA0A4@ws5-11.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Good Day!

Anyone could help me with this error. Thanks in advance.


  CC      net/netfilter/xt_string.o
  CC      net/netfilter/xt_tcpmss.o
  LD      net/netfilter/built-in.o
  CC      net/netlink/af_netlink.o
net/netlink/af_netlink.c: In function `netlink_release':
net/netlink/af_netlink.c:472: error: structure has no member named `protinfo'
net/netlink/af_netlink.c:472: error: structure has no member named `protinfo'
net/netlink/af_netlink.c:473: error: structure has no member named `protocol'
net/netlink/af_netlink.c:474: error: structure has no member named `protinfo'
net/netlink/af_netlink.c: At top level:
net/netlink/af_netlink.c:562: error: redefinition of 'netlink_capable'
net/netlink/af_netlink.c:521: error: previous definition of 'netlink_capable' was here
net/netlink/af_netlink.c: In function `netlink_capable':
net/netlink/af_netlink.c:563: error: structure has no member named `protocol'
net/netlink/af_netlink.c: At top level:
net/netlink/af_netlink.c:1298: error: redefinition of 'netlink_set_nonroot'
net/netlink/af_netlink.c:1292: error: previous definition of 'netlink_set_nonroot' was here
make[2]: *** [net/netlink/af_netlink.o] Error 1
make[1]: *** [net/netlink] Error 2
make: *** [net] Error 2
[root@ja linux-2.6.16]#


-- 
_______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org
This allows you to send and receive SMS through your mailbox.

Powered by Outblaze
