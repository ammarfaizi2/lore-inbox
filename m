Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTG1AOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270989AbTG1AGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:44 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:10502 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270984AbTG0XnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:43:22 -0400
Message-ID: <200307280158250677.10891156@192.168.128.16>
In-Reply-To: <20030727164649.517b2b88.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 01:58:25 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 16:46 David S. Miller wrote:

>No, your problem was completely different.

The setting who show up the problem was different. The problem is the same.

>Bas's problem can be solved by him giving a "preferred source"
>to each of his IPV4 routes and setting the "arpfilter" sysctl
>variable for his devices to "1".

Yes, it's another approach to solve his problem. But he must play with routing.

With the "hidden patch" the only thing he needs is to switch the feature on.

Regards,
Carlos Velasco


