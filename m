Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWC2A7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWC2A7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWC2A7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:59:18 -0500
Received: from asteria.debian.or.at ([86.59.21.34]:8344 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S1750731AbWC2A7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:59:18 -0500
Date: Wed, 29 Mar 2006 02:59:17 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060329005917.GR25288@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org> <20060327061021.GT1173973@melbourne.sgi.com> <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr> <20060328213845.GO25288@asteria.noreply.org> <20060329074214.D871924@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060329074214.D871924@wobbly.melbourne.sgi.com>
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Nathan Scott wrote:

> You'll be better off trying the bio_clone fix discussed in the
> other (ext3-bio_clone-panic) thread than go down this route
> (there is a fix in 2.6.16.1 apparently - start there).  Certainly
> try that before attempting to revert these changes anyway.

The problem persists on 2.6.16.1.

lg,
Peter
