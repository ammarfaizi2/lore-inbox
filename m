Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUHZRdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUHZRdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUHZRdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:33:33 -0400
Received: from mail.shareable.org ([81.29.64.88]:44998 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269261AbUHZR2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:28:52 -0400
Date: Thu, 26 Aug 2004 18:27:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826172703.GR5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?
> 
> No no. The stream you get from a directory is totally _independent_ of the 
> contents of the directory. Anything else would be pointless.

Surely it depends on the directory?

The stream from a "classic directory", i.e. something made with
mkdir(), mode drwxr-xr-x filled with files, might well be a reproducible
representation of its contents.

-- Jamie

