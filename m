Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbTELOrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTELOrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:47:06 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:50949 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262155AbTELOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:47:05 -0400
Date: Tue, 13 May 2003 00:59:19 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Frank Cusack <fcusack@fcusack.com>
cc: linux-kernel@vger.kernel.org, <paulus@samba.org>
Subject: Re: MPPE in kernel?
In-Reply-To: <20030512045929.C29781@google.com>
Message-ID: <Mutt.LNX.4.44.0305130038300.3377-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Frank Cusack wrote:

> What are the chances of getting MPPE (PPP encryption) into the 2.4.21
> and/or 2.5.x kernels?
> 
> For 2.4.21, sha1 and arcfour code needs to be added, so I don't have
> too much hope :-) even though the code is trivial to integrate.
> 
> For 2.5.x, just the arcfour code is needed (since sha1 is already there).
> I've written a public domain implementation, which I'd be willing to
> relicense under GPL (although I don't see the point), but in any case
> the algorithm is easy and could be written by anyone.

One issue is that there is no support in the crypto API yet for stream 
ciphers.


- James
-- 
James Morris
<jmorris@intercode.com.au>

