Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTDXEXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTDXEXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:23:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43152 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264412AbTDXEXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:23:14 -0400
Date: Wed, 23 Apr 2003 20:29:54 -0700 (PDT)
Message-Id: <20030423.202954.85407627.davem@redhat.com>
To: maxk@qualcomm.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
 net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030423182014.07ec6140@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
	<20030423.163043.41633133.davem@redhat.com>
	<5.1.0.14.2.20030423182014.07ec6140@unixmail.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Wed, 23 Apr 2003 18:41:56 -0700

   At 04:30 PM 4/23/2003, David S. Miller wrote:
   >Your stuff was unacceptable from the start because you didn't put
   >the ->owner into the protocol ops.
   But you didn't tell me that. You just said that it's "an ugly hack" without
   giving any other feedback.
    
As you mention, Rusty said this.

   What about this though
   
I'm sure Arnaldo will deal with the sys_accept() issues.
But this is a minor issue, Arnaldo's stuff is architectually
solid.
