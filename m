Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVF3GbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVF3GbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVF3GbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:31:16 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:30178 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262875AbVF3GaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:30:01 -0400
Date: Thu, 30 Jun 2005 08:29:56 +0200
From: David Weinehall <tao@acc.umu.se>
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Hans Reiser <reiser@namesys.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050630062956.GP16867@khan.acc.umu.se>
Mail-Followup-To: Hubert Chan <hubert@uhoreg.ca>,
	Hans Reiser <reiser@namesys.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
	Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <hubert@uhoreg.ca> <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com> <42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871x6kv4zd.fsf@evinrude.uhoreg.ca>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:33:10AM -0400, Hubert Chan wrote:
> On Wed, 29 Jun 2005 20:04:58 -0700, Hans Reiser <reiser@namesys.com> said:
> 
> > Ross Biro wrote:
> >> How is directories as files logically any different than putting all
> >> data into .data files and making all files directories (yes you would
> >> need some sort of special handling for files that were really called
> >> .data).
> 
> > Add to this that you make .data the default if the file within the
> > directory is not specified,
> 
> It's sort of like the way web servers handle index.html, for those who
> think it's a stupid idea.  (Of course, some people may still think it's
> a stupid idea... ;-) )

And guess what?  That's handled on the web server level (userland),
not by the file system.  So different web servers can handle it
differently (think index.html.sv, index.html.zh, index.php, etc).

Amazing isn't it?

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
