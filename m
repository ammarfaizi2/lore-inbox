Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271657AbRHUN2Q>; Tue, 21 Aug 2001 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRHUN15>; Tue, 21 Aug 2001 09:27:57 -0400
Received: from [209.10.41.242] ([209.10.41.242]:56211 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S271657AbRHUN1n>;
	Tue, 21 Aug 2001 09:27:43 -0400
Date: Tue, 21 Aug 2001 16:22:21 +0300
From: =?iso-8859-1?Q?Pekka_Pietik=E4inen?= <pp@netppl.fi>
To: linux-kernel@vger.kernel.org
Cc: Christian Widmer <cwidmer@iiic.ethz.ch>
Subject: Re: SOCK_SEQPACKET
Message-ID: <20010821162221.A23999@netppl.fi>
In-Reply-To: <200108211153.f7LBrpk08803@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108211153.f7LBrpk08803@mail.swissonline.ch>; from cwidmer@iiic.ethz.ch on Tue, Aug 21, 2001 at 01:53:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 01:53:45PM +0200, Christian Widmer wrote:
> hi,
> 
> when reading the man page for sockets i saw the socket SOCK_SEQPACKET
> which meets my requirements quite good. unfortunatly the man page also sais 
> that SOCK_SEQPACKET is not implementet by the protocol famaly PF_INET
> (misleadingly calld AF_INET in the man page). whats about PF_INET6?
Actually SOCK_SEQPACKET works just fine even with PF_INET,
you just need a protocol that uses it :)

For an example implementation that uses it, see STP for Linux
(http://oss.sgi.com/projects/stp).

-- 
Pekka Pietikainen
