Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267711AbTAMJWL>; Mon, 13 Jan 2003 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTAMJWL>; Mon, 13 Jan 2003 04:22:11 -0500
Received: from almesberger.net ([63.105.73.239]:3592 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267711AbTAMJWK>; Mon, 13 Jan 2003 04:22:10 -0500
Date: Mon, 13 Jan 2003 06:30:53 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030113063053.C6866@almesberger.net>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301120053420.21687-100000@dell>; from rpjday@mindspring.com on Sun, Jan 12, 2003 at 01:00:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> 3) currently, since quotas are only supported for ext2, ext3 and
>    reiserfs, shouldn't quotas depend on at least one of those
>    being selected?

The problem with expressing every last dependency is that you'll
end up hiding too much.

A less intrusive approach that doesn't require changes to the
current configuration framework may be to add a section
"Warnings" at the end, under which some pseudo-options would be
enabled if some unusual combinations are found (e.g. CD-ROM
drivers but no ISO9660 file system, PC architecture but no
keyboard, etc.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
