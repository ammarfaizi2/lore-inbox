Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTDXAYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTDXAYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:24:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22671 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264366AbTDXAYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:24:03 -0400
Date: Wed, 23 Apr 2003 16:30:43 -0700 (PDT)
Message-Id: <20030423.163043.41633133.davem@redhat.com>
To: maxk@qualcomm.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
 net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
	<20030423192640.GD26052@conectiva.com.br>
	<5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Max Krasnyansky <maxk@qualcomm.com>
   Date: Wed, 23 Apr 2003 15:51:11 -0700

   >This is just the first part, DaveM already merged the second part,
   >that deals with struct sock 

   That's exactly what surprised me. He rejected complete patch and
   accepted something incomplete and broken.

No, it was not broken, because he told me completely where he
was going with his changes.  He was building infrastructure piece by
piece, and that's always an acceptable way to do things as long
as it is explained where one is going with the changes.

Your stuff was unacceptable from the start because you didn't put
the ->owner into the protocol ops.
   
   I thought changes like that are always discussed on the lkml.

No, networking patches can go solely to netdev or linux-net.
   
