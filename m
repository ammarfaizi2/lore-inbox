Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWGYPIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWGYPIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWGYPIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:08:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:19990 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932408AbWGYPIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:08:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UXt3JamoBidQMnuBzimiK+Pu84WPRA878YWfHgt9/jsOh39dxkkZmnsj9q4jlmUR4QHJsQtullj4aEjzGEWjYM4eYPssLwJnSakMevCEXdXd5nw60umgTV8I2ZHSUbbBl+KWAstcNGnOtVyhCC6jB/MbLDmGxFMMOZd3cMDpOiw=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Tue, 25 Jul 2006 17:08:13 +0200
User-Agent: KMail/1.8.2
Cc: Mike Benoit <ipso@snappymail.ca>, Matthias Andree <matthias.andree@gmx.de>,
       Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
In-Reply-To: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251708.13660.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 July 2006 23:51, Horst H. von Brand wrote:
> > Once the inodes ran out the entire system pretty much came to a
> > screeching halt.
> 
> Get a clue by for, apply to the vendor (for the design, or at the very
> least for not warning unsuspecting users)?
> 
> >                  We basically had two options, use ReiserFS, or find
> > another piece of software that didn't use tiny little files as its
> > database.
> 
> Or reconfigure the filesystem with more inodes (you were willing to rebuild
> the filesystem in any case, so...)

The fact that _many_ UNIX filesystem formats have inode number limit
(configurable only at mkfs time) doesn't make it a good design.

By the same virtue you may declare that it is okay to smoke
and drink lots of vodka. Why not? Sizable portion if population does that...

I, on the contrary, want software to impose as few limits on me
as possible.
--
vda
