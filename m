Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVD2Usk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVD2Usk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVD2Ur4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:47:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:44442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262963AbVD2Ur1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:47:27 -0400
Date: Fri, 29 Apr 2005 13:49:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Sean <seanlkml@sympatico.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050429202341.GB21897@waste.org>
Message-ID: <Pine.LNX.4.58.0504291338540.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
 <20050429191207.GX21897@waste.org> <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
 <20050429202341.GB21897@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> The changeset log (and everything else) has an external index.

I don't actually know exactly how the BK changeset file works, but your 
explanation really sounds _very_ much like it.

I didn't want to do anything that even smelled of BK. Of course, part of
my reason for that is that I didn't feel comfortable with a delta model at
all (I wouldn't know where to start, and I hate how they always end up
having different rules for "delta"ble and "non-delta"ble objects).

But another was that exactly since I've been using BK for so long, I
wanted to make sure that my model just emulated the way I've been _using_
BK, rather than any BK technical details.

So it sounds like it could work fine, but it in fact sounds so much like 
the ChangeSet file that I'd personally not have done it that way. 

			Linus
