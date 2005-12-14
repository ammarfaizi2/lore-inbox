Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVLNQri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVLNQri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVLNQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:47:38 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:44252 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964850AbVLNQrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:47:37 -0500
Date: Wed, 14 Dec 2005 17:47:36 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: [ANNOUNCE] second stable release of Linux-VServer
Message-ID: <20051214164736.GD6778@MAIL.13thfloor.at>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051213185650.GA6466@MAIL.13thfloor.at> <Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com> <20051214143819.GB20138@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214143819.GB20138@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:38:19AM -0600, Serge E. Hallyn wrote:
> Quoting Rik van Riel (riel@redhat.com):
> > On Tue, 13 Dec 2005, Herbert Poetzl wrote:
> > 
> > > Well, as the OpenVZ folks announced their release on LKML
> > > I just decided to do similar for the Linux-VServer release,
> > > so please let me know if that is not considered appropriate.
> > 
> > Since there is a legitimate (and very popular) use case for
> > virtuozzo / vserver functionality, I think it is a good
> > thing to get all the code out in the open.
> > 
> > I really hope we will get something like BSD jail functionality
> > in the Linux kernel.  It makes perfect sense for hosting
> > environments.
> 
> Well a version for 2.6.15-rc2 is still at sf.net/projects/linuxjail.
> I haven't resubmitted to lkml in a long time because I haven't found
> or implemented a better solution for the network virtualization, which
> Christoph wasn't happy with. The vserver ngnet or openvz networking
> may be a good solution. Additionally, the pid virtualization we've
> been discussing (and which should be submitted soon) would remove the
> need for the tasklookup patch, so bsdjail would reduce even further,
> to network and simple access controls.

complete pid virtualization would be interesting for
migration and checkpointing too (not just isolation
and security), so I think that might be something of
interest for a broader audience ...

best,
Herbert

> Note that I would prefer to see the full vserver in the kernel...
> 
> -serge
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
