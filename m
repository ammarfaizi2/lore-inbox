Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271664AbTGRAgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271659AbTGRAgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:36:47 -0400
Received: from [213.13.155.14] ([213.13.155.14]:19472 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S271673AbTGRAfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:35:06 -0400
Subject: Re: SET_MODULE_OWNER
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: davem@redhat.com
Cc: jgarzik@pobox.com, schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030717151647.01e790ea.davem@redhat.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	 <3F16C190.3080205@pobox.com> <200307171756.19826.schlicht@uni-mannheim.de>
	 <3F16C83A.2010303@pobox.com> <20030717125942.7fab1141.davem@redhat.com>
	 <1058477803.754.11.camel@ezquiel.nara.homeip.net>
	 <20030717144031.3bbacee5.davem@redhat.com>
	 <1058480636.754.31.camel@ezquiel.nara.homeip.net>
	 <20030717151647.01e790ea.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1058489395.1142.9.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jul 2003 01:49:55 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Fri, 18 Jul 2003 01:56:32 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 23:16, David S. Miller wrote:
> There are some heavy device leaks in 2.6.0-test1 as released,
> if you could test something more current it would be appreciated
> as we believe we have fixed this.

Indeed you have. Without IPv6, it unloads without a glitch.

> Alternatively, you could test if ipv6 is the culprit by removing
> it from your setup somehow.

With IPv6, it takes a couple of seconds before unloading and I get this
message (just ONE message):
Jul 18 01:36:00 ezquiel kernel: unregister_netdevice: waiting for eth0
to become free. Usage count = 4

Unless this is sympthon of something that shouldn't happen, I can live
with it.

-- 
	Ricardo

