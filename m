Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUIBOlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUIBOlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUIBOlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:41:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39558 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268379AbUIBOjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:39:32 -0400
Message-Id: <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
To: Lee Revell <rlrevell@joe-job.com>
cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@suse.cz>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> 
   of "Wed, 01 Sep 2004 18:51:12 -0400." <1094079071.1343.25.camel@krustophenia.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 02 Sep 2004 10:25:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> said:

[...]

> FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
> option, enabled by default, to look inside archives.  If you tell it to
> look for a driver in a given directory it will also look inside .cab 
> and .zip files.  It's extremely useful, I would imagine someone who uses
> XP a lot will come to expect this feature.

It is trivial to implement this by looking inside the files. I.e., the way
mc has done this for ages.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
