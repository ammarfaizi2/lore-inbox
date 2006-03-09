Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWCIUWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWCIUWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCIUWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:22:31 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:14700 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbWCIUWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:22:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PgmjZisk8r/xKc4M4C4mDkyli215hIFpLhwg40UhNiP7Z+j1aYhs8Mb68dtCdwqN/qV4GW2QTI0r39sHKDYKaQ2Tn0LyfHXYJ0e1Cxi41WrMYQm5zmG8mhybaOEROQVJ9195OzrMjIk4WPvKXo95AfZP480N8M5HMz+JZ51WNo8=
Message-ID: <161717d50603091222p34b45065xdb8507cbf8191a3d@mail.gmail.com>
Date: Thu, 9 Mar 2006 15:22:29 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Xavier Bestel" <xavier.bestel@free.fr>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: "Phillip Susi" <psusi@cfl.rr.com>, Luke-Jr <luke@dashjr.org>,
       "Anshuman Gholap" <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1141928755.7599.0.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com>
	 <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
	 <1141928755.7599.0.camel@bip.parateam.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Xavier Bestel <xavier.bestel@free.fr> wrote:
> Le jeudi 09 mars 2006 à 12:33 -0500, Dave Neuer a écrit :
> > On 3/9/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> > > If binary drivers are illegal, then why have ATI and nvidia not been
> > > sued yet?
> >
> > Because no sufficiently deep-pocketed plaintiff has chosen to do so
> > yet.
>
> No. It's just because they don't distribute a kernel with their drivers.

IF their driver is a derivative work (which many have argued), then it
does not matter that they don't distribute the kernel (which they
would have a perfect right to do, like you or I or anyone else, under
the terms of the GPL); what matters is that copyright law prevents the
CREATION of derivative works without permission, and the GPL states
that permission in this case is contingent upon distributing (*) said
derivative works under the GPL (i.e., full source code availability).

Thus, if binary modules are in fact derivative works, ATI and NVidia
are not legally allowed to distribute them. You may disagree about
whether or not drivers are derivative works; to my knowledge no court
has ruled on this yet.

But I stand by my assertion: many kernel developers on record stating
that they don't want their work used in binary-only modules, and the
reason that this hasn't been decided by a court yet is no sufficiently
deep-pocketed plaintiff (independantly wealthy kernel hackers or a big
corporation with copyright interest in the kernel) has decided to sue,
yet.

See Linus' statements here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0670.html
and here: http://www.ussg.iu.edu/hypermail/linux/kernel/0312.1/0708.html
if you think I'm just pulling this stuff out of my butt.

Regards,
Dave

* the GPL doesn't say you can't use modified or derived GPL software
internally, so ATI and nVidia would presumably be OK if they didn't
distribute the drivers.
