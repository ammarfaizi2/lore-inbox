Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUHXCTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUHXCTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHXCTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:19:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:55975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267566AbUHXCSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:18:14 -0400
Date: Mon, 23 Aug 2004 19:17:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <412A9F8A.5010400@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0408231917370.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <412A9F8A.5010400@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Aug 2004, Brian Gerst wrote:
> 
> Use get/put_cpu() in the GPF handler to prevent preemption while 
> handling the TSS.

Indeed. Good point.

		Linus
