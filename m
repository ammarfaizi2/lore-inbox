Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTKZXrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTKZXre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:47:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264392AbTKZXrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:47:08 -0500
Date: Wed, 26 Nov 2003 15:46:31 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jose Luis Domingo Lopez <linux-net@24x7linux.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6.0-test10-mm1] Typo in
 Documentation/networking/ip-sysctl.txt
Message-Id: <20031126154631.6dbade01.davem@redhat.com>
In-Reply-To: <20031126232200.GA10178@localhost>
References: <20031126232200.GA10178@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003 00:22:00 +0100
Jose Luis Domingo Lopez <linux-net@24x7linux.com> wrote:

> There is a small typo in Documentation/networking/ip-sysctl.txt. It
> still says HZ for i386 architecture is 100, when it is no longer true.
> The following patch should update it to current HZ=1000 for i386.

The value being spoken about, in 2.6.x terms, is actually
USER_HZ which is still 100 on x86.
