Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272586AbTG1AFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTG1AE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29106 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272673AbTG0W5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:57:33 -0400
Date: Sun, 27 Jul 2003 16:09:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] place IPv4 netfilter submenu where it belongs
Message-Id: <20030727160942.647707d8.davem@redhat.com>
In-Reply-To: <20030726200646.GF16160@louise.pinerecords.com>
References: <20030726200646.GF16160@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 22:06:46 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> $subj
> 
> Patch against -bk3.

This doesn't look right at all.

Netfilter is for many protocols other than ipv4 (ipv6, bridging,
decnet, etc.) so putting it under ipv4 makes not much sense
to me.

If anything, probably the "depends on INET" could need correction.
