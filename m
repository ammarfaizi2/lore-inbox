Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFFELZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFFELZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 00:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFFELZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 00:11:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29895 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261172AbVFFELX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 00:11:23 -0400
Message-ID: <42A3CCDF.7000701@pobox.com>
Date: Mon, 06 Jun 2005 00:11:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [patch 2.6.12-rc5] Stop arch/i386/kernel/vsyscall-note.o being
 rebuilt every time
References: <615.1118029984@kao2.melbourne.sgi.com>
In-Reply-To: <615.1118029984@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> arch/i386/kernel/vsyscall-note.o is not listed as a target so its .cmd
> file is neither considered as a target nor is it read on the next
> build.  This causes vsyscall-note.o to be rebuilt every time that you
> run make, which causes vmlinux to be rebuilt every time.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>

Nice, thanks.  That always annoyed me.

	Jeff


