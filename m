Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSAFMfb>; Sun, 6 Jan 2002 07:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSAFMfV>; Sun, 6 Jan 2002 07:35:21 -0500
Received: from epic7.Stanford.EDU ([171.64.15.40]:32391 "EHLO
	epic7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S287841AbSAFMfL>; Sun, 6 Jan 2002 07:35:11 -0500
Date: Sun, 6 Jan 2002 04:34:56 -0800 (PST)
From: Vikram <vvikram@stanford.edu>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
Subject: Re: [ingo patch] 2.4.17 benchmarks
In-Reply-To: <E16NAMs-0000kv-00@phalynx>
Message-ID: <Pine.GSO.4.33.0201060431410.27217-100000@epic7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd blame this partially on the reverted fork() execution order bit of his
> patch. The child process really should be executed first, and performance is
> much improved in that case (COW and things). I don't think we should worry
> about breaking obviously incorrect (and already fragile) programs for 2.5.x.

ok.

and one more thing which i thought i should mention , i used lmbench
2.0 vanilla... i just see that there seems to be 2 patches for 2.0 . i
didnt apply them , maybe i should? are they relevant to this context?

	Vikram

> -Ryan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


