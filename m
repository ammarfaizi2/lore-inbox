Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTHME3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHME3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:29:09 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:5612 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S271375AbTHME3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:29:07 -0400
Date: Wed, 13 Aug 2003 14:29:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ronald Kuetemeier <ron_ker@kuetemeier.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 and dnotify
Message-Id: <20030813142903.2ef2c725.sfr@canb.auug.org.au>
In-Reply-To: <1060705727.1189.12.camel@ronald.kuetemeier.com>
References: <1060705727.1189.12.camel@ronald.kuetemeier.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2003 10:28:47 -0600 Ronald Kuetemeier <ron_ker@kuetemeier.com> wrote:
>
> I run some of my programs on 2.6.0-test3 this morning, before my coffee
> ..., anyhow seems dnotify isn't working any more. I compiled the example
> from <linux-2.6.0-test3>/Documentation/dnotify.txt this also doesn't
> work anymore.
> SMP <2 PIII> system.
> As usual CC me, if possible :-).

Try using (SIGRTMIN + 1) instead of SGIRTMIN.  At some point glibc or bash
(or something) started blocking SIGRTMIN by default ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
