Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbUAIX3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUAIX3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:29:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:3764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264323AbUAIX3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:29:04 -0500
Date: Fri, 9 Jan 2004 15:29:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcus Hartig <marcus@marcush.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1 oopses
Message-Id: <20040109152957.7d5a5559.akpm@osdl.org>
In-Reply-To: <3FFF33B2.1050707@marcush.de>
References: <3FFF33B2.1050707@marcush.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Hartig <marcus@marcush.de> wrote:
>
> patching 2.6.1 to mm1 from A. Morton, the kernel oopses after connecting
> to my dsl provider:

yup, sorry.  You'll need to revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/check-for-truncated-modules.patch

