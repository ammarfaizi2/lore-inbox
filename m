Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVIQK4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVIQK4r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVIQK4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:56:47 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:48259 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751061AbVIQK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:56:47 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Sat, 17 Sep 2005 13:56:14 +0300
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <432B1F84.3000902@namesys.com> <20050917092247.GA13992@infradead.org>
In-Reply-To: <20050917092247.GA13992@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509171356.14497.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 September 2005 12:22, Christoph Hellwig wrote:
> On Fri, Sep 16, 2005 at 12:39:48PM -0700, Hans Reiser wrote:
> > Christoph Hellwig wrote:
> > 
> > >additinoal comment is that the code is very messy, very different
> > >from normal kernel style, full of indirections and thus hard to read.
> > >
> > 
> > Most of my customers remark that Namesys code is head and shoulders
> > above the rest of the kernel code.  So yes, it is different.  In
> > particular, they cite the XFS code as being so incredibly hard to read
> > that its unreadability is worth hundreds of thousands of dollars in
> > license fees for me.  That's cash received, from persons who read it
> > all, not commentary made idly.
> 
> It's very different from kernel style, and it's hard to read for us kernel
> developers.  And yes, I don't think XFS is the most easy to read code either,
> quite contrary.  But it's at least half a magnitude less bad than reiser4
> code..

At least reiser4 is smaller. IIRC xfs is older than reiser4 and had more time
to optimize code size, but:

reiser4        2557872 bytes
xfs            3306782 bytes
--
vda
