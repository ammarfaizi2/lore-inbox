Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVCGIR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVCGIR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVCGIR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:17:56 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:13572 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261680AbVCGIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:17:46 -0500
Date: Mon, 7 Mar 2005 16:15:18 +0800 (WST)
From: raven@themaw.net
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 patch: autofs4_wait can leak memory
In-Reply-To: <16936.33587.974061.237160@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.62.0503071612570.23607@donald.themaw.net>
References: <16936.33587.974061.237160@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-100.1, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Jeff Moyer wrote:

> Hi,
>
> There is a memory in the autofs4_wait function, if multiple processes are
> waiting on the same queue:
>

Well done Jeff.

I'll update my retrospective patch set.

Ian

