Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTEYNkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTEYNkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 09:40:46 -0400
Received: from mcmmta1.mediacapital.pt ([193.126.240.146]:55755 "EHLO
	mcmmta1.mediacapital.pt") by vger.kernel.org with ESMTP
	id S262136AbTEYNkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 09:40:46 -0400
Date: Sun, 25 May 2003 14:53:19 +0100
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
Subject: Re: Question on verify_area() and friends wrt
In-reply-to: <20030525130706.B9127@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <20030525145319.6f66a8aa.l16083@alunos.uevora.pt>
Organization: Universidade de Evora
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20030525124625.4dedc758.l16083@alunos.uevora.pt>
 <20030525130706.B9127@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick reply, Cristoph.

One more question arises though...

On Sun, 25 May 2003 13:07:06 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> verify_area only does some checks so you need to check the return
> value from copy_to_user.  You could switch to __copy_to_user, though.

Why would __copy_to_user be a good choice? AFAIK, __copy_to_user does no
validy checks (as opposed to copy_to_user which does access_ok()) so,
considering verify_area() does only some checks, one could argue that
there's even less checking done if using __copy_to_user. Where am I
interpreting this wrong (as I certainly am) ?

Thanks again,


		Paulo
