Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSCLW43>; Tue, 12 Mar 2002 17:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSCLW4T>; Tue, 12 Mar 2002 17:56:19 -0500
Received: from chmls20.ne.ipsvc.net ([24.147.1.156]:56458 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S274862AbSCLW4D>; Tue, 12 Mar 2002 17:56:03 -0500
Date: Tue, 12 Mar 2002 17:37:38 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020312223738.GB29832@pimlott.ne.mediaone.net>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
	Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0203110051500.9713-100000@weyl.math.psu.edu> <3C8C4B8A.2070508@namesys.com> <nn4rjmoh02.fsf@code.and.org> <3C8DB535.7080807@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8DB535.7080807@namesys.com>
User-Agent: Mutt/1.3.27i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 10:58:45AM +0300, Hans Reiser wrote:
> Clearcase handles all of this in the filesystem, and it all works pretty 
> much reasonably.

This is misleading--Clearcase stores versions on top a normal
filesystem (like most other RCS's), and all manipulation is entirely
in user-space (over the network to server processes).  There only
filesystem magic is that there are directories you cannot list (plus
permission semantics are a little funny).

Seems very different from what you're proposing, IIUC.

Andrew
