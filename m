Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUEZChy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUEZChy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 22:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUEZChy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 22:37:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:60369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265290AbUEZChx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 22:37:53 -0400
Date: Tue, 25 May 2004 19:37:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
Message-Id: <20040525193721.7c71f61d.akpm@osdl.org>
In-Reply-To: <40B400D1.1080602@jp.fujitsu.com>
References: <40B1BEAC.30500@jp.fujitsu.com>
	<20040524023453.7cf5ebc2.akpm@osdl.org>
	<40B3F484.4030405@jp.fujitsu.com>
	<20040525184148.613b3d6e.akpm@osdl.org>
	<40B400D1.1080602@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com> wrote:
>
> Sorry, I resend document and patch.

Great, thanks.  Updates to Documentation/kernel-parameters.txt and
Documentation/filesystems/proc.txt would be nice.


If the machine locks up with interrupts enabled we can use sysrq-T and
sysrq-P.  If it locks up with interrupts disabled the NMI watchdog will
automatically produce the same info as your patch.  So what advantage does
the patch add?
