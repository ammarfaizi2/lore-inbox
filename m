Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGYVsQ>; Thu, 25 Jul 2002 17:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGYVsQ>; Thu, 25 Jul 2002 17:48:16 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:30409 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316574AbSGYVsQ>;
	Thu, 25 Jul 2002 17:48:16 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 15:44:25 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725154425.T2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <1027637183.11604.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027637183.11604.8.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 25, 2002 at 11:46:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't lose the hex data.  The patch just prints data that the kernel
already has.  For some situations this patch does match the needs of
developers better.

} I would much rather have hex data. It makes all the parsing tools
} connected to the serial port that much easier. If instead of hacking the
} kernel you bang out a little bit of expect you can do it all on the host
} driving the embedded box, and find the file names, and open them in an
} editor at the right function, and do a parallel lookup in bugzilla for
} matching oops logs...
