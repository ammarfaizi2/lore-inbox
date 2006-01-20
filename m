Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWATQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWATQuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWATQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:50:21 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:24802 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751082AbWATQuU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:50:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hgHy0f7FU0xaFjN0cx3IPsFHFtgaWRIT1sWXK6ZG28PXxSaNxnEsCA2dwD6WoU5MIb3i4af+R33oWypX4EcL/rsknejdMtDEAOp4kVyTUvqT/j6yi5uRVezwRE67T6GXuSER4heqk7jMHEcm/gSpj7vKTLzXqht/NdEKJFZ6xY0=
Message-ID: <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
Date: Fri, 20 Jan 2006 17:43:22 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Harald Welte <laforge@netfilter.org>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
Cc: Jiri Slaby <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "David S.Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060120163619.GK4603@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	 <20060120162317.5F70722B383@anxur.fi.muni.cz>
	 <20060120163619.GK4603@sunbeam.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Harald Welte <laforge@netfilter.org> wrote:
> On Fri, Jan 20, 2006 at 05:23:18PM +0100, Jiri Slaby wrote:
>
> > Commit 4f2d7680cb1ac5c5a70f3ba2447d5aa5c0a1643a (Linus' 2.6 git tree) breaks my
> > iptables (1.3.4):
>
> You missed to indicate on which architecture?

On x86 (32bits), i have the same i think:
# iptables  -L
ERROR: 0 not a valid target)
Aborted

I can provide a strace if necessary.

regards,

Benoit
