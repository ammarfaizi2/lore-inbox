Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUH1SVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUH1SVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUH1SVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:21:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267495AbUH1SVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:21:35 -0400
Date: Sat, 28 Aug 2004 14:20:19 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408281419220.17315-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Linus Torvalds wrote:
> Well.. Yes. We already have "." and "..", which are "special extra
> streams" in a sense. However, people expect them, and know to ignore them. 
> The same wouldn't be true of new naming.

If the streams that don't contain data weren't real
files, but instead fifos, backup programs would ignore
them fine.

Tar seems to ignore special nodes ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

