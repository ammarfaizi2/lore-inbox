Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVAKQKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVAKQKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVAKQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:10:32 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:700 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S262813AbVAKQKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:10:22 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: linux-kernel@vger.kernel.org
Subject: Re: Bad things happening to journaled filesystem machines; Was: Oops in kjournald
Date: Tue, 11 Jan 2005 17:10:53 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501111710.53730.as@cohaesio.com>
X-OriginalArrivalTime: 11 Jan 2005 16:10:22.0221 (UTC) FILETIME=[0D69E3D0:01C4F7F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well I just want to count my self in. - I have had quite a few of these
errors,
both on XFS and EXT3. I tried a lot of different 2.6.x kernels without
luck. (See other mails here on LKML from me and Jakob Oestergaard et al.) 

It seems something is very broken in VFS(?) on 2.6 (atleast after 2.6.5,
which was the last kernel I didn't see this on, but had other errors that
forced me away from it).

Sadly it looks to me as if either noone cares (enough) about this, or noone
is capable of fixing it (myself included). :( 

- 2.4.28 fixed it for me. - Just have to live with the poor performance.

Jeffrey E. Hundstad wrote:

> I've had 4 machines do the similiar things.  It happens during backups
> or during updatedb.  This has happened on 2.6.9, 2.6.10, 2.6.10-ac7, and
> 2.6.10-ac8.  I've seen several similiar reports with journaled file
> systems.  I use XFS exclusively; but have seen reports on XFS and EXT3.
> I would report something more useful but what I'm usually left with is
> XFS unmounted and nothing useful on the screen.  This has been on Xeon,
> Pentium-3 and Athlon systems. ...wish I could report more but perhaps it
> will add /part/ of a data point.
> 

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
