Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTF1C12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 22:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTF1C12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 22:27:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:51291 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265043AbTF1C11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 22:27:27 -0400
Date: Fri, 27 Jun 2003 19:41:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: ldl@aros.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from
 nbd_init
Message-Id: <20030627194154.01a06c5d.akpm@digeo.com>
In-Reply-To: <200306271943.13297.mflt1@micrologica.com.hk>
References: <200306271943.13297.mflt1@micrologica.com.hk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 02:41:43.0282 (UTC) FILETIME=[CF4E1520:01C33D1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mflt1@micrologica.com.hk> wrote:
>
> Changes were recently made to the nbd.c in 2.5.73-mm1

And tons more will be in -mm2, which I shall prepare right now.
Please retest on that and if it still hangs, capture the output
from pressing alt-sysrq-T.

Thanks.
