Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVDHHpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVDHHpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVDHHpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:45:50 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:23276 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262729AbVDHHpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:45:42 -0400
X-ME-UUID: 20050408074540886.D85F51C002A9@mwinf0208.wanadoo.fr
Date: Fri, 8 Apr 2005 09:41:35 +0200
To: debian-legal@lists.debian.org
Cc: linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408074135.GA9057@pegasos>
References: <20050407161658.S32136@links.magenta.com> <MDEHLPKNGKAHNMBLJOLKEEPFCPAB.davids@webmaster.com> <20050407235544.Y32136@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050407235544.Y32136@links.magenta.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:55:44PM -0400, Raul Miller wrote:
> > > Also, "mere aggregation" is a term from the GPL.  You can read what
> > > it says there yourself.  But basically it's there so that people make
> > > a distinction between the program itself and other stuff that isn't
> > > the program.
> 
> On Thu, Apr 07, 2005 at 04:20:50PM -0700, David Schwartz wrote:
> >	It's also there because the GPL can only apply to either works
> > placed under it by their authors and works that are legally classified
> > as derivative. If you merely aggregate two works, there is no
> > derivation. The GPL is making clear that it's not trying to exceed the
> > scope of its authority (which is copyright law).
> 
> The issue of whether or not the combined work is a derivative under
> copyright law is a copyright law issue.  The GPL does concern itself
> with that issue, but not in the "mere aggregation" clause.
> 
> The "mere aggregation" clause holds regardless of whether or not the
> combined work is a derivative under copyright law.
> 
> [P.S. I've set the Reply-To: header on this message because I think this
> thread has drifted away from kernel issues.]

Thanks.

BTW, have any of you read the analysis i made, where i claim, rooted in the
GPL FAQ and with examples, why i believe that the firmware can be considerated
a non derivative of the linux kernel. The main points is that the firmware is
not aimed to run in the same address space, even not the same cpu, as the rest
of the linux kernel, and that there is a clearly defined communication channel
between the GPLed driver and the target processor running the firmware.

I further argumented that taking any different stance would bring us worlds of
hurt as we would consider the bios as being a derivative work of the kernel
they are running, or the bootloader, or the firmware present in proms on
devices loaded into the system and so on.

I think only the fact that if you consider firmware as being a derivative
work, you should consider it a derivative work also when it is flashed on the
prom of a pci card or what not, is decisive enough to make those firmware
blobs not derivative works of the kernel they are under.

Friendly,

Sven Luther

