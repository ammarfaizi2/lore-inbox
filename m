Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUHZM2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUHZM2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUHZM2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:28:30 -0400
Received: from levante.wiggy.net ([195.85.225.139]:56992 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268929AbUHZMZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:25:52 -0400
Date: Thu, 26 Aug 2004 14:25:49 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826122549.GM2612@wiggy.net>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Rik van Riel <riel@redhat.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
	Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
	Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com> <20040826121223.GG30449@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826121223.GG30449@mail.shareable.org>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jamie Lokier wrote:
> I find losing mtime annoying.  That's why I don't use Mozilla's
> download manager (and Navigator's before it) because they presumed
> that mtime isn't worth copying.

It's free software, you could fix that :)

> Is it a problem to decree that "file data MUST NOT be stored in a
> metadata directory; only non-essential metadata and data computed from
> the file data may be stored"?

That would put us right back at the samba-and-other-apps-want-streams
point in the discussion, but it certainly would not be a bad starting
point. From there we could always add streams later on if the API is
right.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
