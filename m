Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUAIVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbUAIVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:31:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:20952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264397AbUAIVbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:31:15 -0500
Date: Fri, 9 Jan 2004 13:32:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, benh@kernel.crashing.org
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
Message-Id: <20040109133229.06cc2410.akpm@osdl.org>
In-Reply-To: <1073672901.2069.15.camel@laptop-linux>
References: <1073672901.2069.15.camel@laptop-linux>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
>
> This patch makes console X and Y coordinates unsigned, rather than
> signed. Issues with wide (> 128 char?) consoles, seen when developing
> Software Suspend's 'nice display' are thus fixed. A brief examination of
> related code showed that this use of signed variables was the exception
> rather than the rule.

You'll probably find that all you needed to do was to convert the chars
over to unsigned, not the integers.

But whatever.

