Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269180AbUHZSHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269180AbUHZSHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUHZSE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:04:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269147AbUHZSCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:02:06 -0400
Date: Thu, 26 Aug 2004 13:57:33 -0400 (EDT)
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
In-Reply-To: <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Linus Torvalds wrote:

> > So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?
> 
> No no. The stream you get from a directory is totally _independent_ of the 
> contents of the directory. Anything else would be pointless.

It's a relief to know that nobody's taking my humorous
suggestion seriously, but now we still have the "standard
Unix tools can't manipulate files" problem...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

