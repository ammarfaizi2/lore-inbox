Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbUK3CdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUK3CdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUK3Ccl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:32:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2715 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261952AbUK3CcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:32:25 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Frank <mhf@linuxmail.org>, linux-kernel@vger.kernel.org,
       SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>
Subject: Re: [PATCH 2.6.9] KDB: Fix compile problem when CONFIG_KPROBES and CONFIG_KDB set 
In-reply-to: Your message of "Mon, 29 Nov 2004 12:09:48 PDT."
             <20041129190948.GH22325@smtp.west.cox.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Nov 2004 13:31:10 +1100
Message-ID: <10051.1101781870@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 12:09:48 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>On Sun, Nov 28, 2004 at 04:18:46AM +0800, Michael Frank wrote:
>
>> Both  kprobes and kdb defined function do_int3.
>> Both functions were merged.
>
>Is there a reason KDB (or KPROBES for that matter) can't use the notifyr
>chain?  That's what KGDB does...

It's on my todo list for kdb v4.5.

