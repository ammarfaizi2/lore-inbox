Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFYUwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFYUwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFYUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:52:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63467 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261313AbVFYUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:52:46 -0400
Message-ID: <42BDC422.6020401@namesys.com>
Date: Sat, 25 Jun 2005 13:52:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
In-Reply-To: <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> Hmm.. let's see.. I said Reiser isn't in because it shouldn't be
> screwing with
>
>the VFS, and said stuff should be done separate from the Reiser4 filesystem.
>  
>
We don't touch a line of VFS code.  We look like a normal fs at the
interface.

Shall we send in a file labeled reiservfs.c containing the plugin layer?
That will really test whether the Reiser name is cursed that way, yes?

There has been no response to the technical email asking for what
exactly it is that is duplicative, and what exactly it is that ought to
be changed in how the code works, as opposed to what file the code is
placed in, or who is considered its maintainer.    There has been no
response to the questions about whether the difference between class and
instance makes our layer non-duplicative.

Perhaps no response was possible?

Hans
