Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbSJSKR2>; Sat, 19 Oct 2002 06:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSJSKR2>; Sat, 19 Oct 2002 06:17:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8145 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265586AbSJSKR2>;
	Sat, 19 Oct 2002 06:17:28 -0400
Date: Sat, 19 Oct 2002 03:15:45 -0700 (PDT)
Message-Id: <20021019.031545.02857658.davem@redhat.com>
To: helge.hafting@broadpark.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 compile failure, net/ipv4/raw.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DB12F8F.86C0B2E0@broadpark.no>
References: <3DB12F8F.86C0B2E0@broadpark.no>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change the "#include <linux/netfilter.h" in net/ipv4/raw.c
to "#include <linux/netfilter_ipv4.h"
