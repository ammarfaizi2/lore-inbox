Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUHXEbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUHXEbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUHXEbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:31:16 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:7314 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268282AbUHXEa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:30:59 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 21:30:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <412A9F8A.5010400@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0408232130040.3245@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <412A9F8A.5010400@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Brian Gerst wrote:

> Use get/put_cpu() in the GPF handler to prevent preemption while 
> handling the TSS.

Will do and repost. Thx!


- Davide

