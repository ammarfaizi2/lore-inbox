Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVDYTDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVDYTDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDYTDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:03:43 -0400
Received: from mail.shareable.org ([81.29.64.88]:41128 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262729AbVDYTDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:03:40 -0400
Date: Mon, 25 Apr 2005 20:03:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Jan Hudec <bulb@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425190315.GA28294@mail.shareable.org>
References: <3WWn1-2ZC-3@gated-at.bofh.it> <3WWwR-3hT-35@gated-at.bofh.it> <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Use a daemon to keep an additional reference to the namespace? That's UGLY.

Why not?  There's a daemon already: the FUSE daemon.  It's an ideal
candidate for passing out the information about the mounts it's
involved in.

-- Jamie
