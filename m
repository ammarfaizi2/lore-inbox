Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWGGLII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWGGLII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWGGLII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751039AbWGGLIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:08:07 -0400
Date: Fri, 7 Jul 2006 04:07:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: splice/tee bugs?
Message-Id: <20060707040749.97f8c1fc.akpm@osdl.org>
In-Reply-To: <20060707070703.165520@gmx.net>
References: <20060707070703.165520@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 09:07:03 +0200
"Michael Kerrisk" <mtk-manpages@gmx.net> wrote:

> c) Occasionally the command line just hangs, producing no output.
>    In this case I can't kill it with ^C or ^\.  This is a 
>    hard-to-reproduce behaviour on my (x86) system, but I have 
>    seen it several times by now.

aka local DoS.  Please capture sysrq-T output next time.
