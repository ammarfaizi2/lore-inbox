Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272457AbTG0WyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272450AbTG0WyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:54:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51698 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272381AbTG0WyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:54:12 -0400
Date: Sun, 27 Jul 2003 15:12:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bas Bloemsaat <bloemsaa@xs4all.nl>
Cc: marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727151234.6e2aa57e.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 22:52:48 +0200 (CEST)
Bas Bloemsaat <bloemsaa@xs4all.nl> wrote:

> I think this is unwanted behaviour.

Not a bug.  This behavior is on purpose.

Use source based routes if you want to control how ARP
responses behave in this way.

This is becomming a FAQ.
