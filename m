Return-Path: <linux-kernel-owner+w=401wt.eu-S1751051AbXAORfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbXAORfh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAORfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:35:36 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:34021 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXAORfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:35:36 -0500
Message-ID: <45ABBB64.3060304@fr.ibm.com>
Date: Mon, 15 Jan 2007 18:35:32 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 7/8] user_ns: handle file sigio
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181257.GH11377@sergelap.austin.ibm.com> <20070111212039.68e57e65.akpm@osdl.org> <20070115072653.GA7385@sergelap.austin.ibm.com> <45AB97D5.6010503@fr.ibm.com> <20070115152825.GA20350@sergelap.austin.ibm.com>
In-Reply-To: <20070115152825.GA20350@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ ... ]

> Rewriting the userns testcases right now.  Clearly, in addition to
> separately testing clone and unshare, I need to add a sigioperm check,
> and have a separate set of testcases for CONFIG_USER_NS=n.

Could we get rid of CONFIG_USER_NS ? 

It doesn't look that useful anyway, it just deactivates the unshare 
capability for the user namespace. 

Same question for the other mainline namespaces, IPC and utsname. 

C.
