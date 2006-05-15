Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWEOTi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWEOTi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEOTi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:38:56 -0400
Received: from mail.aknet.ru ([82.179.72.26]:37641 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751638AbWEOTiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:38:55 -0400
Message-ID: <4468D8CA.6070702@aknet.ru>
Date: Mon, 15 May 2006 23:38:50 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfault on the i386 enter instruction
References: <44676F42.7080907@aknet.ru> <20060515074019.GA33242@muc.de> <4468B733.7010101@aknet.ru> <20060515184401.GA89194@muc.de>
In-Reply-To: <20060515184401.GA89194@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andi Kleen wrote:
> Linux doesn't have a STACK_RLIMIT by default no.
By default - OK, I thought you mean that it doesn't have
the STACK_RLIMIT at all (doesn't implement it).

> It is set by a few distributions (for use with flexmmap) in PAM, but
> not by all. The kernel defaults don't have it.
That might explain why I get
$ ulimit -s
8192
on fedora core.
Thanks for explanations.

