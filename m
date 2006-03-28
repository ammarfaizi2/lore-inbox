Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWC1Jn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWC1Jn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWC1Jn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:43:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:15254 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751281AbWC1Jn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:43:28 -0500
X-Authenticated: #428038
Date: Tue, 28 Mar 2006 11:43:22 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <20060328094322.GA345@merlin.emma.line.org>
Mail-Followup-To: Bodo Eggert <7eggert@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org> <Pine.LNX.4.58.0603271306140.3209@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603271306140.3209@be1.lrz>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert schrieb am 2006-03-27:

> As I understand, having a /dev/sd0815 corresponding to a /dev/sg4711 is
> the root of all evil and idiotic things, and moving all sg functions into
> the apropiate place is the sane thing to do.
> 
> This patch is a part of the process, and as soon as all sg functions are
> available using /dev/s[dtr]*, the corresponding sg devices should be
> deprecated and removed.

Oh, I hear Schilling wailing...

Seriously, at the time such changes are committed, a good manual for how
user-space applications are to be upgraded wouldn't hurt, and I am
indeed proposing that those familiar with the code should write it -
perhaps when porting an existing application to the new interfaces.

-- 
Matthias Andree
