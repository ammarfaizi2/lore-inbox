Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSLMGLa>; Fri, 13 Dec 2002 01:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSLMGL3>; Fri, 13 Dec 2002 01:11:29 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:64680 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261427AbSLMGL3>;
	Fri, 13 Dec 2002 01:11:29 -0500
Date: Fri, 13 Dec 2002 17:18:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH][COMPAT] consolidate sys32_new[lf]stat - architecture independent
Message-Id: <20021213171852.0eab19cc.sfr@canb.auug.org.au>
In-Reply-To: <20021212.213231.63672402.davem@redhat.com>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
	<20021212.213231.63672402.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002 21:32:31 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
> 
> I'm totally fine with this stuff (and the sparc64 specific part), but
> watch out, this patch removes the kernel/compat.c utimes stuff :-)

And adds it into fs/compat.c where it should have been in the first place ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
