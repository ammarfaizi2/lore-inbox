Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCRWjK>; Mon, 18 Mar 2002 17:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCRWjB>; Mon, 18 Mar 2002 17:39:01 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:27143 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293181AbSCRWiw>;
	Mon, 18 Mar 2002 17:38:52 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15510.25987.233438.112897@argo.ozlabs.ibm.com>
Date: Tue, 19 Mar 2002 09:09:07 +1100 (EST)
To: David Woodhouse <dwmw2@infradead.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug 
In-Reply-To: <28998.1016469387@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> After it's been in -ac for a while without mishap I'll ask Marcelo to
> consider it - possibly for 2.4.20-pre1.

Yep, that sounds good to me.  For now, I think my patch should go in
for 2.4.19.

Anyone who is using PPP with Deflate compression on an older 2.4.x
kernel (or for that matter a 2.2.x kernel) should apply my patch
also, or at least the part of it that affects drivers/net/zlib.c.

Paul.
