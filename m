Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUHZSPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUHZSPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUHZSPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:15:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269293AbUHZSHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:07:43 -0400
Date: Thu, 26 Aug 2004 13:59:29 -0400 (EDT)
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
In-Reply-To: <20040826194010.548e4a4c.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44.0408261358370.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Diego Calleja wrote:
> El Thu, 26 Aug 2004 13:16:22 -0400 (EDT) Rik van Riel <riel@redhat.com> escribió:
> 
> > So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?
> 
> /bin could be separated (like linus said) but cat /bin/.compound could
> do it. This is the /etc/passwd Hans' example, I think:

Arghhhh.  I wrote it down to ridicule the idea and now people
are taking it seriously ;(

It should be obvious enough that anything depending on the
kernel parsing file contents will lead to problems.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

