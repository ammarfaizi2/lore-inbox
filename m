Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272341AbTG3Xzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTG3Xzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:55:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39628 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272341AbTG3Xze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:55:34 -0400
Date: Wed, 30 Jul 2003 16:49:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: jgarzik@pobox.com, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.22-pre9-bk : bonding bug fixes
Message-Id: <20030730164907.43b2d343.davem@redhat.com>
In-Reply-To: <20030730140658.GA14437@alpha.home.local>
References: <20030730140658.GA14437@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 16:06:58 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> there are still a few bugs in the current bonding driver. I've reported them
> several times now, but perhaps not at the right places...

So now we have these few bug fixes, and the backport of the
2.6.x version of the bonding code, both submitted on the same
day in fact :-)

Jeff I'd recommend we put Willy's fixes in if you think they're
OK, then we can think about the 2.6.x backport work for 2.4.23-preX
