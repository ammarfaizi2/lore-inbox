Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265046AbUEYSwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbUEYSwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUEYSve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:51:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:20964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265042AbUEYSv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:51:29 -0400
Date: Tue, 25 May 2004 11:51:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Collins <bcollins@debian.org>
cc: Dave Jones <davej@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <20040525180628.GJ1286@phunnypharm.org>
Message-ID: <Pine.LNX.4.58.0405251148090.9951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <20040525131139.GW1286@phunnypharm.org> <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org>
 <20040525171805.GG1286@phunnypharm.org> <20040525180225.GA2668@redhat.com>
 <20040525180628.GJ1286@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Ben Collins wrote:
> 
> Linus could just concern himself with atleast us subsystem-maintainers
> putting the Signed-off-by on there and not worry himself about the other
> headers.

Note that this is how it's supposed to always work, except you should 
replace "Linus" with "any maintainer".

At any point in the chain, you should always have to worry only about the
"immediate predecessor". That's why the certificate is "recursive", ie if
the immediate predecessor signed off, then you can always sign off
yourself, without worrying about any history, and you've done the "right
thing".

		Linus
