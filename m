Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUH0OOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUH0OOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUH0OOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:14:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2772 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265264AbUH0OOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:14:43 -0400
Date: Fri, 27 Aug 2004 10:12:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412EEB75.1030401@namesys.com>
Message-ID: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Hans Reiser wrote:

> Why are you guys even considering going to any pain at all to distort 
> semantics for the sake of backup?  tar is easy, we'll fix it and send in 
> a patch. 

Because not everybody uses tar.  Quite a few people use a
network backup system, while others use duplicity, RPM uses
cpio internally and big companies tend to use proprietary
network backup suites.

Breaking people's setup is something to worry about.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

