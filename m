Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTEFUdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTEFUdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:33:22 -0400
Received: from [12.47.58.20] ([12.47.58.20]:25189 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261824AbTEFUdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:33:21 -0400
Date: Tue, 6 May 2003 13:42:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux@1g6.biz, linux-kernel@vger.kernel.org
Subject: Re: oops 2.5.68 ohci1394/ IRQ/acpi
Message-Id: <20030506134213.48c0b3db.akpm@digeo.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A28E@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A28E@orsmsx401.jf.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 20:45:47.0435 (UTC) FILETIME=[78BF6FB0:01C31410]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> wrote:
>
> Ohhh so we need to not just return nonzero, but return 1 (aka
> IRQ_HANDLED?) Well, then this makes sense. Sorry about that.

Yup.  Unfortunately Nicolas reports that the patch made no difference.


