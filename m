Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269506AbUHZUPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269506AbUHZUPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269561AbUHZUPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:15:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269496AbUHZUN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:13:27 -0400
Date: Thu, 26 Aug 2004 16:10:48 -0400 (EDT)
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
In-Reply-To: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Linus Torvalds wrote:

> So "/tmp/bash" is _not_ two different things. It is _one_ entity, that
> contains both a standard data stream (the "file" part) _and_ pointers to
> other named streams (the "directory" part).

Thinking about it some more, how would file managers and
file chosers handle this situation ?

Currently the user browses the directory tree and when
the user clicks on something, one of the following 
happens:

1) if it is a directory, the file manager/choser changes
   into that directory

2) if it is a file, the file is opened

Now how do we present things to users ?

How will users know when an object can only be chdired
into, or only be opened ?

For objects that do both, how does the user choose ?

Do we really want to have a file paradigm that's different
from the other OSes out there ?

What happens when users want to transfer data from Linux
to another system ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

