Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVDAJR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVDAJR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVDAJR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:17:56 -0500
Received: from lug-owl.de ([195.71.106.12]:29369 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262663AbVDAJRv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:17:51 -0500
Date: Fri, 1 Apr 2005 11:17:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove all kernel bugs
Message-ID: <20050401091750.GS21175@lug-owl.de>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050401090744.GD15453@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050401090744.GD15453@waste.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 01:07:44 -0800, Matt Mackall <mpm@selenic.com>
wrote in message <20050401090744.GD15453@waste.org>:
> I've been sitting on this patch for a while, figured it's high time I
> shared it with the world. This patch eliminates all kernel bugs, trims
> about 35k off the typical kernel, and makes the system slightly
> faster. The patch is against the latest bk snapshot, please apply.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>

Well, the patch looks fine, but you forgot to also do the VAX-specific
part. Withoug the BUGs, maybe the VAX kernel would be even faster?

:-), JBG

-- 
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
