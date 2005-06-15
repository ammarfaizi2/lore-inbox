Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVFOUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFOUtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVFOUsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:48:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:7430 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261559AbVFOUrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:47:49 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NETFILTER]: Advance seq-file position in exp_next_seq()
References: <200506140159.j5E1xRb7019657@hera.kernel.org>
Date: Wed, 15 Jun 2005 22:47:43 +0200
In-Reply-To: <200506140159.j5E1xRb7019657@hera.kernel.org> (Linux Kernel
	Mailing List's message of "Mon, 13 Jun 2005 18:59:27 -0700")
Message-ID: <87u0jzny8g.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linux Kernel Mailing List:

> tree f33460f2f2452807483ba6453e3319dcfe4bf856
> parent 814d8ffd5009e13f1266759b583ef847c5350d77
> author Patrick McHardy <kaber@trash.net> Tue, 14 Jun 2005 08:27:13 -0700
> committer David S. Miller <davem@davemloft.net> Tue, 14 Jun 2005 08:27:13 -0700
>
> [NETFILTER]: Advance seq-file position in exp_next_seq()

Unfortunately, this still doesn't fix the "ip_ct_tcp: SEQ is over the
upper bound (over the window of the receiver)" regression some people
see since 2.6.9.  (It probably doesn't intent to, either, but I was
associating freely and arranged for a test.)
