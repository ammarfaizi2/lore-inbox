Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281162AbRKUBrx>; Tue, 20 Nov 2001 20:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKUBrp>; Tue, 20 Nov 2001 20:47:45 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53753
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281162AbRKUBq3>; Tue, 20 Nov 2001 20:46:29 -0500
Date: Tue, 20 Nov 2001 17:46:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS, Paging & Installing [was: Re: Swap]
Message-ID: <20011120174622.A12996@mikef-linux.matchmail.com>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Steffen Persvold <sp@scali.no>,
	Christopher Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011120135059.D4210@mikef-linux.matchmail.com> <200111210122.fAL1MwhC029913@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111210122.fAL1MwhC029913@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 10:22:58PM -0300, Horst von Brand wrote:
> Mike Fedyk <mfedyk@matchmail.com> said:
> > Do any newer versions of NFS fix the stateless server problem?
> 
> This is an _extremely_ hard problem: The server has to know somehow what
> the client thinks the state is... and either one (or both) may have been
> rebooted in between without the other one knowing.

Yep, but there are currently protocols (SMB) that do that, but not
necessarily in a unix way.

Are there any that do this now with linux?  Locking over the network just
like it is locally?
