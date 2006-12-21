Return-Path: <linux-kernel-owner+w=401wt.eu-S1422645AbWLUDkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWLUDkz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWLUDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:40:54 -0500
Received: from [202.112.49.247] ([202.112.49.247]:43266 "EHLO
	netarchlab.tsinghua.edu.cn" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1422673AbWLUDky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:40:54 -0500
Date: Thu, 21 Dec 2006 11:40:14 +0800
From: "xlz" <xlz@netarchlab.tsinghua.edu.cn>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "netfilter-devel" <netfilter-devel@lists.netfilter.org>
Subject: A problem of tunnel and netfilter
Message-ID: <200612211140095153132@netarchlab.tsinghua.edu.cn>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,
	I find that the ipip_tunnel_xmit() funtion is called before NF_HOOK(...NF_IP_LOCAL...), but I can't understand the reason. Why isn't the ipip_tunnel_xmit() funtion called after NF_HOOK(...NF_IP_LOCAL...)?

	Thanks in advance for any answers!

xlz
2006-12-21


