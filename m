Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUI2I5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUI2I5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUI2I5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:57:02 -0400
Received: from [213.146.154.40] ([213.146.154.40]:2717 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268274AbUI2I47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:56:59 -0400
Subject: Re: Compressed filesystems:  Better compression?
From: David Woodhouse <dwmw2@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <415A302E.5090402@comcast.net>
References: <415A302E.5090402@comcast.net>
Content-Type: text/plain
Message-Id: <1096448216.30942.147.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 29 Sep 2004 09:56:57 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 23:46 -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I wonder what compression Squashfs, cramfs, and zisofs use.  I think
> cramfs uses zlib compression; I don't know of any other compression in
> the kernel tree, so I assume zisofs uses the same, as does squashfs.  Am
> I mistaken?

JFFS2 has a variety of compression options too. In fact, it might be
nice to make a generic compression framework (or just use the crypto
one) instead of having that in JFFS2 itself.

-- 
dwmw2

