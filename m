Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUAZLSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbUAZLSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:18:43 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:2237 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265603AbUAZLSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:18:42 -0500
Date: Mon, 26 Jan 2004 12:18:39 +0100
From: David Weinehall <tao@debian.org>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.0.39] drivers/char/baycom.c Zero Sized File
Message-ID: <20040126111839.GD20879@khan.acc.umu.se>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@lovecn.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4014EE22.9070902@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4014EE22.9070902@lovecn.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 06:38:26PM +0800, Coywolf Qi Hunt wrote:
> Hello, David
> 
> I downloaded 2.0.39 from kernel.org, and find that the file 
> drivers/char/baycom.c is a zero sized.
> Also see this http://lxr.linux.no/source/drivers/char/baycom.c?v=2.0.39
> 
> Only Documentation/magic-number.txt describes:
> 
> BAYCOM_MAGIC        0x3105bac0  struct baycom_state  drivers/char/baycom.c

drivers/char/baycom.c is zero-sized in 2.0.38 too, so at least it's not
my fault ;-)

I'm CC:ing Alan, he might have some idea?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
