Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265202AbRF0BlA>; Tue, 26 Jun 2001 21:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265208AbRF0Bkt>; Tue, 26 Jun 2001 21:40:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30605 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265202AbRF0Bkk>;
	Tue, 26 Jun 2001 21:40:40 -0400
Date: Tue, 26 Jun 2001 21:40:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot 
In-Reply-To: <E15F43r-0003ls-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0106262138370.18037-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Jun 2001, Paul Menage wrote:

> But only root can set this up, since you currently have to be root in
> order to chroot(). The (only) advantage of the user chroot() patch would
> be that users would be able to do the same thing without root
> intervention.

You need to be root to do mknod. You need to do mknod to create /dev/zero.
You need /dev/zero to get anywhere near the normal behaviour of the system.

