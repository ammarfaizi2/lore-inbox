Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbUDRHDp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbUDRHDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 03:03:45 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:28289
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264146AbUDRHDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 03:03:44 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.or>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040418032638.GA1786@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <20040416090331.GC22226@mail.shareable.org>
	 <1082130906.2581.10.camel@lade.trondhjem.org>
	 <20040416184821.GA25402@mail.shareable.org>
	 <1082142401.2581.131.camel@lade.trondhjem.org>
	 <20040416193914.GA25792@mail.shareable.org>
	 <1082241169.3930.14.camel@lade.trondhjem.org>
	 <20040418032638.GA1786@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082271815.3619.104.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 00:03:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 20:26, Jamie Lokier wrote:

>       Are they intended to stop doubling at 3.2?  The major timeout
>       thus happens after 22.3 seconds.
> 
>       Unsurprisingly, subsequent major timeouts take 44.1 seconds.

Right... ...but since the timeout value is already capped at 60 seconds,
this is not a major problem. It is pretty pointless to be talking about
"predictable" or "consistent" behaviour when talking about a situation
where we believe that the server has crashed.

AFAICS, all we care about is to establish a predictable *lower limit*.

Cheers,
  Trond
