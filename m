Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVBWXc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVBWXc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBWXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:32:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22252 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261686AbVBWXa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:30:29 -0500
Date: Wed, 23 Feb 2005 17:29:24 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: accept() fails with EINTER
In-reply-to: <3B6CS-3oH-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <421D11D4.1060607@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3B6CS-3oH-23@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> Trying to run an old server with a new kernel. A connection
> fails with "interrupted system call" as soon as a client
> attempts to connect. A trap in the code to continue
> works, but subsequent send() and recv() calls fail in
> the same way.
> 
> Anybody know how to mask that SIGIO (or whatever signal)?
> Setting signal(SIGIO, SIG_IGN) doesn't do anything useful.

Well, knowing what signal it actually is would help.. tried running it 
in a debugger?
