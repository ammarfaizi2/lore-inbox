Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSDMThF>; Sat, 13 Apr 2002 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSDMThE>; Sat, 13 Apr 2002 15:37:04 -0400
Received: from ns.suse.de ([213.95.15.193]:1544 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310206AbSDMThE>;
	Sat, 13 Apr 2002 15:37:04 -0400
Date: Sat, 13 Apr 2002 21:37:00 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020413213700.A17884@wotan.suse.de>
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com> <20020413012142.A25295@kushida.apsleyroad.org> <20020413083952.A32648@wotan.suse.de> <m1662vjtil.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 01:19:46PM -0600, Eric W. Biederman wrote:
> Could the garbage from ext3 in writeback mode be considered an
> information leak?  I know that is why most places in the kernel
> initialize pages to 0.  So you don't accidentally see what another
> user put there.

Yes it could. But then ext2/ffs have the same problem and so far people were
able to live on with that.

-Andi
