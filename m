Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272380AbTGaFVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272388AbTGaFVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:21:03 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:43274 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272380AbTGaFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:21:01 -0400
Date: Thu, 31 Jul 2003 15:20:48 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Frank v Waveren <fvw@var.cx>
cc: linux-kernel@vger.kernel.org, <Andries.Brouwer@cwi.nl>,
       <linux-crypto@nl.linux.org>
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
In-Reply-To: <1059627605AME.fvw@tracks.var.cx>
Message-ID: <Mutt.LNX.4.44.0307311515260.21304-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Frank v Waveren wrote:

> Owch. But I assume this didn't sneak in since the testing cryptoAPI
> patches? Or have the algorithms been redone?

I'm not sure what you mean.

> 
> > > Lastly: Why the move from a /proc/crypto directory containing files
> > > for all the algorithms to one monolithic /proc/crypto file? Isn't the
> > > former a lot nicer from the userspace programmer's point of view?
> > Possibly, although it's probably too late to change now for 2.6.
> But why was it ever changed to on big file in the first place?
> 

This is a new API, so it wasn't really changed.  The single file is
simpler and less bloated from the kernel point of view.  This may change 
down the track with hardware support.



- James
-- 
James Morris
<jmorris@intercode.com.au>

