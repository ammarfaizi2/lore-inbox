Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTJCGoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTJCGoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:44:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39837 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263578AbTJCGoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:44:14 -0400
Date: Thu, 2 Oct 2003 23:39:45 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at arch/sparc64/kernel/module.c:207 (2.6.0-test6)
Message-Id: <20031002233945.6bd985f9.davem@redhat.com>
In-Reply-To: <1065113449.7140.18.camel@kusturica>
References: <1065113449.7140.18.camel@kusturica>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Oct 2003 18:50:49 +0200
Magosányi Árpád <mag@bunuel.tii.matav.hu> wrote:

> Loading modules...
>    iptable_filter
> kernel BUG at arch/sparc64/kernel/module.c:207!

Most modules do not trigger this, because I am loading all kinds
of modules on sparc64 successfully.

Is it only the iptable module that triggers this?

If many modules do this for you, I rather suspect your build
environment.
