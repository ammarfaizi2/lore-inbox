Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTELWEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTELWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:04:39 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:54299 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262817AbTELWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:04:02 -0400
Date: Mon, 12 May 2003 15:16:29 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: MPPE in kernel?
Message-ID: <20030512151629.D30310@google.com>
References: <20030512045929.C29781@google.com> <Mutt.LNX.4.44.0305130038300.3377-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0305130038300.3377-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Tue, May 13, 2003 at 12:59:19AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 12:59:19AM +1000, James Morris wrote:
> On Mon, 12 May 2003, Frank Cusack wrote:
> 
> > What are the chances of getting MPPE (PPP encryption) into the 2.4.21
> > and/or 2.5.x kernels?
> > 
> > For 2.4.21, sha1 and arcfour code needs to be added, so I don't have
> > too much hope :-) even though the code is trivial to integrate.
> > 
> > For 2.5.x, just the arcfour code is needed (since sha1 is already there).
> > I've written a public domain implementation, which I'd be willing to
> > relicense under GPL (although I don't see the point), but in any case
> > the algorithm is easy and could be written by anyone.
> 
> One issue is that there is no support in the crypto API yet for stream 
> ciphers.

Doesn't need it, AFAICT.  The caller keeps the state.

/fc
