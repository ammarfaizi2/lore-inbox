Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTJKTWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTJKTWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:22:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14466 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263382AbTJKTWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:22:35 -0400
Date: Sat, 11 Oct 2003 12:16:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       irda-users@lists.sourceforge.net, netdev@oss.sgi.com
Subject: Re: Linux 2.4.23-pre7 (irda compile fixes)
Message-Id: <20031011121635.4eb39ca6.davem@redhat.com>
In-Reply-To: <20031010162302.GA1526@suse.de>
References: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
	<20031010162302.GA1526@suse.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 18:23:02 +0200
Olaf Hering <olh@suse.de> wrote:

> The attached patch converts all printk(__FUNCTION__); to
> printk("%s", __FUNCTION__);
> gcc34 doesnt accept the current code anymore, irda doesnt compile.

Applied, thanks Olaf.
