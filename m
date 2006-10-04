Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWJDMrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWJDMrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWJDMrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:47:40 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:6928 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932340AbWJDMrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:47:39 -0400
Date: Wed, 4 Oct 2006 08:39:42 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, Jean Tourrilhes <jt@hpl.hp.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004123935.GB9277@tuxdriver.com>
References: <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com> <20061003194957.GB17855@bougret.hpl.hp.com> <20061004022100.GC6110@jm.kir.nu> <1159947203.3000.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159947203.3000.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:33:23AM +0200, Arjan van de Ven wrote:
> On Tue, 2006-10-03 at 19:21 -0700, Jouni Malinen wrote:

> > (And based on the other messages in this thread, it might be useful to
> > include the userspace program's idea of the version in those new
> > commands to allow multiple interface versions to be supported by the
> > kernel).
> 
> 
> or... don't use a NUMBER for this.
> 
> If you have a bitmap for supported features, it's much more powerful!
> That way you can even do this per driver/hardware, and you can
> add/retract individual capabilities rather than lumping everything into
> one big number.

Arjan (as usual) makes a very good suggestion here...

-- 
John W. Linville
linville@tuxdriver.com
