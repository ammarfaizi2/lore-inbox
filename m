Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269675AbUHZWEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269675AbUHZWEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269712AbUHZWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:04:28 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6916 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269659AbUHZWD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:03:57 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: silent semantic changes with reiser4
Date: Fri, 27 Aug 2004 00:03:33 +0200
User-Agent: KMail/1.7
Cc: Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, wichert@wiggy.net, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261416360.27909-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408261416360.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408270003.34686.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 20:17, Rik van Riel wrote:
> On Thu, 26 Aug 2004, Jeremy Allison wrote:
> > Because without kernel support there is no way someone can
> > publish a new metadata type and have it automatically supported
> > by all application data files (ie. most apps ignore it, and only
> > apps that are aware of it can see it).
>
> So your backup software ignores it, and after a restore you've
> lost your new metadata ?

I think there's no easy way to fix this, except fixing the backup software to 
support xattrs's/streams/forks/whatever. Even on Windows, it has happened 
this way with older apps that don't support named streams.
