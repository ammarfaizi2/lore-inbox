Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCOKdI>; Fri, 15 Mar 2002 05:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCOKc7>; Fri, 15 Mar 2002 05:32:59 -0500
Received: from angband.namesys.com ([212.16.7.85]:12417 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289272AbSCOKcq>; Fri, 15 Mar 2002 05:32:46 -0500
Date: Fri, 15 Mar 2002 13:32:41 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020315133241.A1636@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020311154852.3981c188.skraw@ithnet.com> <20020311165140.A1839@namesys.com> <15500.47144.705329.809604@charged.uio.no> <20020311165722.692209c3.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311165722.692209c3.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 11, 2002 at 04:57:22PM +0100, Stephan von Krawczynski wrote:

> Conclusion: reiserfs has a problem being nfs-mounted as the only fs to a
> client. If you add another fs (here ext2) mount, then even reiserfs is happy.
> The problem is originated at the server side.
> Any ideas for a fix?

Ok I tried your scenario of mounting fs1, then mounting fs2, do io on fs2,
umount fs2 and access fs1 and everything went fine.
I cannot reproduce this at all. :(

Bye,
    Oleg
