Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268551AbTAND3U>; Mon, 13 Jan 2003 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268549AbTAND3R>; Mon, 13 Jan 2003 22:29:17 -0500
Received: from havoc.daloft.com ([64.213.145.173]:49124 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268544AbTAND3Q>;
	Mon, 13 Jan 2003 22:29:16 -0500
Date: Mon, 13 Jan 2003 22:38:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Valdis.Kletnieks@vt.edu
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030114033803.GG404@gtf.org>
References: <20030114025452.656612C385@lists.samba.org> <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:28:14PM -0500, Valdis.Kletnieks@vt.edu wrote:
> Out of curiosity, who's job is it to avoid the race condition between when
> this function takes the strlen() and the other processor makes it a longer
> string before we return from kmalloc() and do the strcpy()?

The caller's.

