Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUHZSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUHZSee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269279AbUHZSeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:34:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:51142 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269328AbUHZSXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:23:48 -0400
Date: Thu, 26 Aug 2004 19:20:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rik van Riel <riel@redhat.com>
Cc: Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826182042.GU5733@mail.shareable.org>
References: <20040826194010.548e4a4c.diegocg@teleline.es> <Pine.LNX.4.44.0408261358370.27909-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408261358370.27909-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > /bin could be separated (like linus said) but cat /bin/.compound could
> > do it. This is the /etc/passwd Hans' example, I think:
> 
> Arghhhh.  I wrote it down to ridicule the idea and now people
> are taking it seriously ;(
> 
> It should be obvious enough that anything depending on the
> kernel parsing file contents will lead to problems.

This is one case where the kernel _isn't_ parsing file contents,
but I agree it's ridiculous :)

-- Jamie
