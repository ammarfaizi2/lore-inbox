Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSGCA3g>; Tue, 2 Jul 2002 20:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSGCA3f>; Tue, 2 Jul 2002 20:29:35 -0400
Received: from t10-201.gprs.mtsnet.ru ([213.87.10.201]:23168 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314340AbSGCA3f>; Tue, 2 Jul 2002 20:29:35 -0400
Date: Wed, 3 Jul 2002 04:31:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020703043119.A804@localhost.park.msu.ru>
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru> <20020701090353.B1957@tricia.dyndns.org> <20020701180252.A15288@jurassic.park.msu.ru> <yw1xvg7z1bjz.fsf@gladiusit.e.kth.se> <20020702190544.A23788@jurassic.park.msu.ru> <20020702161322.A7642@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020702161322.A7642@twiddle.net>; from rth@twiddle.net on Tue, Jul 02, 2002 at 04:13:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 04:13:22PM -0700, Richard Henderson wrote:
> Do we have any way of recognizing v4 vs v5 binaries?  I don't think
> we do.

Indeed. I've specially looked for this yesterday, and it seems that             
we don't.                                                                       

> I'd be willing to call any ECOFF binary an OSF binary, and
> ignore the fact that Linux used them in the distant past.

Totally acceptable, I think.

> The minimum correct solution is to add a PER_OSF4 to personality.h
> and put an osf_readv and osf_writev that, if PER_OSF4, read and frob
> the data into kernel buffers and pass that on to the regular syscalls.

It would be excellent.

Ivan.
