Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272657AbTG1E3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272660AbTG1E3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:29:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31157 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272657AbTG1E3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:29:34 -0400
Date: Sun, 27 Jul 2003 21:39:56 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: carlosev@newipnet.com, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727213956.6ede8008.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0307272133140.24695-100000@dlang.diginsite.com>
References: <20030727175557.1d624b36.davem@redhat.com>
	<Pine.LNX.4.44.0307272133140.24695-100000@dlang.diginsite.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Jul 2003 21:37:10 -0700 (PDT)
David Lang <david.lang@digitalinsight.com> wrote:

> P.S. there are standards that are written documents and there are
> standards that are 'how everyone does it' for the most part Linux follows
> both types of standards, in this case the network team has decided to
> ignore the 'how everyone else does it' standards becouse there is nothing
> in a written standard that they are violating

Keep in mind that we implemented sys_sendfile() with different
arguments and semantics than everyone else.

