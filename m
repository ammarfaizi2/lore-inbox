Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUH0J2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUH0J2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUH0JZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:25:29 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:47114 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269263AbUH0JVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:21:05 -0400
Date: Fri, 27 Aug 2004 10:19:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Allison <jra@samba.org>
Cc: Jamie Lokier <jamie@shareable.org>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827101956.B29672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeremy Allison <jra@samba.org>, Jamie Lokier <jamie@shareable.org>,
	Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
	vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
	spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net,
	reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <20040826204841.GC5733@mail.shareable.org> <20040826205218.GE1570@legion.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040826205218.GE1570@legion.cup.hp.com>; from jra@samba.org on Thu, Aug 26, 2004 at 01:52:18PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:52:18PM -0700, Jeremy Allison wrote:
> On Thu, Aug 26, 2004 at 09:48:41PM +0100, Jamie Lokier wrote:
> > 
> > This is why I favour storing all essential metadata (about the file's
> > content) inside the file's contents, the primary stream.
> > 
> > We have another problem: what happens when users want to transfer data
> > from Windows (with secondary streams) and MacOS (with resource forks)?
> 
> I can tell you that - right now we (Samba) has to drop all but the primary stream,
> because the Linux filesystems don't have data stream support. Oh look,
> we're losing user data (that's a *bad* thing :-).

Maybe you should learn from netatalk.

