Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSJMUpt>; Sun, 13 Oct 2002 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSJMUos>; Sun, 13 Oct 2002 16:44:48 -0400
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:25510
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S261733AbSJMUnx>; Sun, 13 Oct 2002 16:43:53 -0400
Date: Sun, 13 Oct 2002 22:49:41 +0200
From: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 breaks Soundblaster OSS driver and smbfs modules
Message-ID: <20021013204941.GA5010@hswn.dk>
References: <20021013154435.GA25380@hswn.dk> <Pine.LNX.4.44.0210132029310.23052-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210132029310.23052-100000@cola.enlightnet.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 08:49:37PM +0200, Urban Widmark wrote:
> On Sun, 13 Oct 2002, Henrik Størner wrote:
> 
> > Yes, I still have an old SB16 ISA card in my machine. Works
> > fine i 2.5.41, but with 2.5.42 I get this:
> > 
> > osiris:~ $ sudo /sbin/depmod -ae
> > depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/smbfs/smbfs.o
> > depmod:         do_schedule
> 
> My local 2.5.42 tree doesn't have any references to do_schedule at all.
> Any funny patches?

Whoops - seems you are right. I apparently forgot to do a modules_install
after trying out the 2.5.42-mm2 patch, which is where the do_schedule
came from.

Sorry about the false alarm.

-- 
Henrik Storner <henrik@hswn.dk> 

