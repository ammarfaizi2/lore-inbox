Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266138AbRGSXAf>; Thu, 19 Jul 2001 19:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGSXAZ>; Thu, 19 Jul 2001 19:00:25 -0400
Received: from ja.ssi.bg ([212.95.166.64]:23557 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S266150AbRGSXAT>;
	Thu, 19 Jul 2001 19:00:19 -0400
Date: Fri, 20 Jul 2001 02:01:10 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <3B576458.F542C473@transmeta.com>
Message-ID: <Pine.LNX.4.33.0107200158200.1820-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


	Hello,

On Thu, 19 Jul 2001, H. Peter Anvin wrote:

> Julian Anastasov wrote:
> >
> > What I want to say (I could be wrong and that can't surprise me) is
> > that the original cpuid_eax is in fact incorrect. All cpuid_XXX funcs
> > use only dummy output operands...
> >
>
> Bullsh*t.  One of the output operands is always a non-dummy (in
> cpuid_edx() edx is not a dummy, for example.)

	Right, and it is may be not damaged. In my first posting I
claim that cpuid_eax damages ebx (and may be ecx and edx).

> 	-hpa


Regards

--
Julian Anastasov <ja@ssi.bg>

