Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRA2VJI>; Mon, 29 Jan 2001 16:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbRA2VI7>; Mon, 29 Jan 2001 16:08:59 -0500
Received: from [213.95.15.193] ([213.95.15.193]:64264 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129878AbRA2VIo>;
	Mon, 29 Jan 2001 16:08:44 -0500
Date: Mon, 29 Jan 2001 22:08:40 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <ln@tantalophile.demon.co.uk>
Cc: Andi Kleen <ak@muc.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        John Fremlin <vii@altern.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, paulus@linuxcare.com, linux-ppp@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
Message-ID: <20010129220840.A7206@gruyere.muc.suse.de>
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.> <200101290245.f0T2j2Y438757@saturn.cs.uml.edu> <20010129135905.B1591@fred.local> <20010129193136.A11035@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129193136.A11035@pcep-jamie.cern.ch>; from ln@tantalophile.demon.co.uk on Mon, Jan 29, 2001 at 07:31:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 07:31:36PM +0100, Jamie Lokier wrote:
> The important thing is that the tunnel is destroyed and recreated (it
> has to be, it is over different underlying link addresses).  I do not
> want that to destroy the connections from the tunnelled address.

Just do not set IFF_DYNAMIC on the tunnel interface then, that is why it is a 
flag and not hardcoded.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
