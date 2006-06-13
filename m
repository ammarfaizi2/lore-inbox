Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932848AbWFMDv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbWFMDv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWFMDvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:51:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16786 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932843AbWFMDvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:51:43 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards. Also VFS time granularity bug on creat(). (Repost, more content)
Date: Tue, 13 Jun 2006 05:49:19 +0200
User-Agent: KMail/1.9.3
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Al Viro <viro@zeniv.linux.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060611115421.GE26475@curie-int.vc.shawcable.net> <p73ac8isgv9.fsf@verdi.suse.de> <Pine.LNX.4.64.0606122024330.18760@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606122024330.18760@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130549.19767.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I did once embark on looking at it from a CONFIG_SWAP point of view;
> but didn't get far before more urgent work intervened.  And your
> argument grows weaker, with filesystems spreading through drivers,
> and even to arch (spufs).

True, but these are usually pseudo file systems just containing 
a few kernel generated files where most "real" fs related stuff doesn't matter much.

-Andi
