Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUJFWcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUJFWcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUJFW3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:29:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:50071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269540AbUJFWZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:25:32 -0400
Date: Wed, 6 Oct 2004 15:29:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __init poisoning for i386, too
Message-Id: <20041006152924.5ae6e94d.akpm@osdl.org>
In-Reply-To: <20041006221854.GA1622@elf.ucw.cz>
References: <20041006221854.GA1622@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Overwrite __init section so calls to __init functions from normal code
> are catched, reliably. I wonder if this should be configurable... but
> it is configurable on x86-64 so I copied it. Please apply,

No, I'll change it to just enable the thing unconditionally.
