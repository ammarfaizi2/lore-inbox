Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbTCTAKz>; Wed, 19 Mar 2003 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbTCTAKz>; Wed, 19 Mar 2003 19:10:55 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:27777 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S261224AbTCTAKy>; Wed, 19 Mar 2003 19:10:54 -0500
Date: Thu, 20 Mar 2003 00:21:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, mirrors <mirrors@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320002127.GB7887@mail.jlokier.co.uk>
References: <3E78D0DE.307@zytor.com> <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, H. Peter Anvin wrote:
> i) Does this sound reasonable to everyone?  In particular, is there any
> loss in losing the "original" compressed files?

Personally I fetch the .bz2 tar files for a few base kernel versions,
but I fetch the .gz patch files.

This is so that I can "zgrep" through the patch files looking for
which version changed some feature or API.

bzgrep exists, but it is way too slow.

So if there were only .bz2 patch files, I would fetch them and convert
them back into .gz files on my local mirror.

Which is ok of course, but then the signatures don't match any more.

Well, that's my really weak reason for liking .gz patches.

enjoy,
-- Jamie
