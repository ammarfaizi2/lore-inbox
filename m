Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUAKNHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAKNHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:07:08 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62475 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265859AbUAKNHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:07:06 -0500
Date: Sun, 11 Jan 2004 14:18:57 +0100
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040111131857.GA11246@hh.idb.hist.no>
References: <1073771855.3958.15.camel@nidelv.trondhjem.org> <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 11:42:45PM +0100, Guennadi Liakhovetski wrote:
> 
> The only my doubt was - yes, you upgrade the __server__, so, you look in
> Changes, upgrade all necessary stuff, or just upgrade blindly (as does
> happen sometimes, I believe) a distribution - and the server works, fine.
> What I find non-obvious, is that on updating the server you have to
> re-configure __clients__, see? Just think about a network somewhere in a

If you upgrade the server and read "Changes", then a note in changes might
say that "you need to configure carefully or some clients could get in trouble."
(If the current "Changes" don't have that - post a documentation patch.)

If you use a distro, then hopefully the distro takes care of the
problem for you.  Or at least brings it to your attention somehow.

It should not come as a surprise that changing a server might have an
effect on the clients - clients and servers are connected after all!

Helge Hafting
