Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbULQRVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbULQRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbULQRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:21:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:40362 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262078AbULQRVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:21:07 -0500
Message-ID: <41C31485.8040102@osdl.org>
Date: Fri, 17 Dec 2004 09:16:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selva kumar <mailnselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New System call & Kernel compilation
References: <20041217102631.43898.qmail@web52106.mail.yahoo.com>
In-Reply-To: <20041217102631.43898.qmail@web52106.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selva kumar wrote:
> selva:
>   After adding a new system call, should we have to
> recompile the whole kernel? can anyone help me
> regarding this?

Yes, it's expected that you rebuild the kernel
(at least all affected files), then reboot that
kernel to use the new syscall.

OTOH, there has been some recent email on lkml about
dynamic syscalls and a way to allow them (mostly for
experimental use AIUI, but if that's the case, just
rebuilding and rebooting would probably do for most
people).

-- 
~Randy
