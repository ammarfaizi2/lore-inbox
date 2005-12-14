Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLNOif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLNOif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVLNOif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:38:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65173 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932228AbVLNOie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:38:34 -0500
Date: Wed, 14 Dec 2005 08:38:19 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: vserver@list.linux-vserver.org
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: [ANNOUNCE] second stable release of Linux-VServer
Message-ID: <20051214143819.GB20138@sergelap.austin.ibm.com>
References: <20051213185650.GA6466@MAIL.13thfloor.at> <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rik van Riel (riel@redhat.com):
> On Tue, 13 Dec 2005, Herbert Poetzl wrote:
> 
> > Well, as the OpenVZ folks announced their release on LKML
> > I just decided to do similar for the Linux-VServer release,
> > so please let me know if that is not considered appropriate.
> 
> Since there is a legitimate (and very popular) use case for
> virtuozzo / vserver functionality, I think it is a good
> thing to get all the code out in the open.
> 
> I really hope we will get something like BSD jail functionality
> in the Linux kernel.  It makes perfect sense for hosting
> environments.

Well a version for 2.6.15-rc2 is still at sf.net/projects/linuxjail.  I
haven't resubmitted to lkml in a long time because I haven't found or
implemented a better solution for the network virtualization, which
Christoph wasn't happy with.  The vserver ngnet or openvz networking may
be a good solution.  Additionally, the pid virtualization we've been
discussing (and which should be submitted soon) would remove the need
for the tasklookup patch, so bsdjail would reduce even further, to
network and simple access controls.

Note that I would prefer to see the full vserver in the kernel...

-serge
