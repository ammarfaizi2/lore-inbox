Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265070AbUEKXvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbUEKXvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265068AbUEKXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:48:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:34984 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbUEKXro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:47:44 -0400
Date: Tue, 11 May 2004 16:50:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040511165013.08ef86cd.akpm@osdl.org>
In-Reply-To: <200405120127.33391.bzolnier@elka.pw.edu.pl>
References: <Pine.LNX.3.96.1040511121328.16430C-100000@gatekeeper.tmr.com>
	<200405120127.33391.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> There was some evidence from AKPM (and Arjan AFAIR).
> [ BTW wasn't the corruption only seen with nvidia module? ]
> I think we can prevent it by adding something ala 4kstack flag
> to the module.

"4KSTACKS" already is present in the module version string.

And RHL is shipping now with 4k stacks, so presumably any disasters
are relatively uncommon...
