Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTAFDRg>; Sun, 5 Jan 2003 22:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTAFDRf>; Sun, 5 Jan 2003 22:17:35 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:31923 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S265857AbTAFDQf>; Sun, 5 Jan 2003 22:16:35 -0500
From: Richard Stallman <rms@gnu.org>
To: akpm@digeo.com
CC: andre@pyxtechnologies.com, riel@conectiva.com.br, andrew@indranet.co.nz,
       linux-kernel@vger.kernel.org
In-reply-to: <3E179CCF.F4CAE1E5@digeo.com> (message from Andrew Morton on Sat,
	04 Jan 2003 18:47:43 -0800)
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Reply-to: rms@gnu.org
References: <Pine.LNX.4.10.10301041740090.421-100000@master.linux-ide.org> <3E179CCF.F4CAE1E5@digeo.com>
Message-Id: <E18VNt1-0008Rq-00@fencepost.gnu.org>
Date: Sun, 05 Jan 2003 22:25:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I suggest that if a function happens to be implemented as an inline
    in a header then it should be treated (for licensing purposes) as
    an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.

The Linux developers can certainly do this, if the copyright holders
of the substantial functions in question go along with it.  Even if
they already went along with linking to their functions from non-free
modules, this is still somewhat different.

The question only arises for the specific non-small functions that are
to be inlined in headers in this way.  (Inlining a very small function
from a header is probably not significant for copyright.)  Perhaps the
copyright holders of these functions are few and easy to ask.




