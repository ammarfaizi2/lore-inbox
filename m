Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUHZRc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUHZRc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUHZRZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:25:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269079AbUHZRTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:19:36 -0400
Date: Thu, 26 Aug 2004 13:16:22 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Diego Calleja <diegocg@teleline.es>
cc: jamie@shareable.org, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       <spam@tnonline.net>, <akpm@osdl.org>, <wichert@wiggy.net>,
       <jra@samba.org>, <torvalds@osdl.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826190548.3e67726f.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Diego Calleja wrote:

> All this looks like reinventing the file/directory concept wheel.
> Instead of adding support for streams and "use files as directories",
> why not orientate it to "use directories as files? Streams could very
> well be provided by directories containing files,

So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?

This is getting surreal.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

