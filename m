Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284330AbRLMQZk>; Thu, 13 Dec 2001 11:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284366AbRLMQZd>; Thu, 13 Dec 2001 11:25:33 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:55451 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S284330AbRLMQZP>;
	Thu, 13 Dec 2001 11:25:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: esr@thyrsus.com, Keith Owens <kaos@ocs.com.au>
Subject: Re: [kbuild-devel] CML2 1.9.7 is available
Date: Thu, 13 Dec 2001 09:29:05 -0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011212023556.A8819@thyrsus.com> <16992.1008153373@ocs3.intra.ocs.com.au> <20011213034930.A8337@thyrsus.com>
In-Reply-To: <20011213034930.A8337@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011213162508.F30944674@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 December 2001 1:49 am, Eric S. Raymond wrote:
> Keith Owens <kaos@ocs.com.au>:
> > OUCH!  The output from make menuconfig has significantly more options
> > than make oldconfig when given exactly the same input.  I thought one
> > of the selling points for CML2 was different front ends but with
> > identical back end processing.  I don't like the way that the
> > resulting config varies when fed to different front ends.
>
> Not a big deal -- all the produced config.outs are logically equivalent.

Not a big deal in theory, maybe, but it is very convenient to use diff to 
compare .config files, and diff doesn't know about logical equivalence.

-- 
Bjorn Helgaas - bjorn_helgaas@hp.com
Linux Systems Operation R&D
Hewlett-Packard
