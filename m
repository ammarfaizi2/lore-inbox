Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbUK2TfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUK2TfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUK2Td4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:33:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54992 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261622AbUK2TJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:09:51 -0500
Date: Mon, 29 Nov 2004 12:09:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org,
       SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>
Subject: Re: [PATCH 2.6.9] KDB: Fix compile problem when CONFIG_KPROBES and CONFIG_KDB set
Message-ID: <20041129190948.GH22325@smtp.west.cox.net>
References: <200411280418.47543.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411280418.47543.mhf@linuxmail.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 04:18:46AM +0800, Michael Frank wrote:

> Both  kprobes and kdb defined function do_int3.
> Both functions were merged.

Is there a reason KDB (or KPROBES for that matter) can't use the notifyr
chain?  That's what KGDB does...

-- 
Tom Rini
http://gate.crashing.org/~trini/
