Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270989AbTG1AOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272590AbTG1AGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270989AbTG0Xet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:34:49 -0400
Date: Sun, 27 Jul 2003 16:46:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727164649.517b2b88.davem@redhat.com>
In-Reply-To: <200307280140470646.1078EC67@192.168.128.16>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<200307280140470646.1078EC67@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 01:40:47 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> I stepped into the same problems you have reported here.

No, your problem was completely different.

> There's a feature to do linux to behave like other OS and systems, called "hidden".

WRONG!  People please stop this misinformation already.

Bas's problem can be solved by him giving a "preferred source"
to each of his IPV4 routes and setting the "arpfilter" sysctl
variable for his devices to "1".

This particular case has been discussed to death in the past
and I really recommend people read up there before dragging this
out further.
