Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269306AbUH0DDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269306AbUH0DDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 23:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUHZSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:53:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269364AbUHZSnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:43:40 -0400
Date: Thu, 26 Aug 2004 14:41:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408261440550.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Linus Torvalds wrote:

> For example, you _could_ probably (but hey, maybe "tar" tries to strip
> slashes off the end of filenames, so this might not work due to silly
> reasons like that) back up a compound file with
> 
> 	tar cvf file.tar file file/

So you'd have both a file and a directory that just happen
to have the same name ?  How would this work in the dcache?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

