Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTFBR2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbTFBR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:28:33 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:17557 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264810AbTFBR2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:28:25 -0400
Date: Mon, 2 Jun 2003 19:43:21 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: "Fryderyk Mazurek" <dedyk@go2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel(2.4.21-rc6) BUG on slab.c
Message-Id: <20030602194321.047ac157.kristian.peters@korseby.net>
In-Reply-To: <MCBBKNJEDBEANFAMJPFPMECGCBAA.dedyk@go2.pl>
References: <MCBBKNJEDBEANFAMJPFPMECGCBAA.dedyk@go2.pl>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.21-rc6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Importance: high
X-Priority: 1 (Highest)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fryderyk Mazurek" <dedyk@go2.pl> schrieb:
> Jun  2 00:32:12 frycek kernel: kernel BUG at slab.c:1439!
> Jun  2 00:32:13 frycek kernel: invalid operand: 0000
> Jun  2 00:32:13 frycek kernel: CPU:    0
> Jun  2 00:32:13 frycek kernel: EIP:    0010:[<c0132390>]    Tainted: PF
								^^^^^^^^

That's related to the ati drivers you're using.. You must get in contact with ati. Their drivers are for specific vendor-kernels only and won't work together with other versions. Maybe you can convince them they'd better release them under a free license..

*Kristian
