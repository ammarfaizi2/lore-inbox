Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUDAGNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUDAGNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:13:00 -0500
Received: from av2-2-sn3.vrr.skanova.net ([81.228.9.108]:40341 "EHLO
	av2-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262709AbUDAGMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:12:33 -0500
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, vladislav.yasevich@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 - SCTP 'make xconfig' issue
References: <20040328042608.GA17969@logos.cnet>
	<m2r7vcss6a.fsf@p4.localdomain>
	<Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Apr 2004 07:24:20 +0200
In-Reply-To: <Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
Message-ID: <m2zn9wi83f.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala <sri@us.ibm.com> writes:

> On Sun, 28 Mar 2004, Peter Osterlund wrote:
> 
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> >
> > > Sridhar Samudrala:
> > >   o [SCTP] Avoid the use of hacking CONFIG_IPV6_SCTP__ option
> > >
> > > Please test!
> >
> > I get an error when selecting save and exit in "make xconfig":
> >
> >   ERROR - Attempting to write value for unconfigured variable (CONFIG_IP_SCTP)
> 
> Vladislav Yasevich did some investigation into this issue and he came
> out with the conclusion that this is due to a bug in the parser for
> 'make xconfig'(tkparse). 'make menuconfig' and 'make oldconfig' should work
> fine.
...
> He came up with the following patch that works around this issue with
> tkparse.  Could you please verify if this works for you?

It works fine for me. Thanks.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
