Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSELS5q>; Sun, 12 May 2002 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSELS5p>; Sun, 12 May 2002 14:57:45 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:32481 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315370AbSELS5p>; Sun, 12 May 2002 14:57:45 -0400
Date: Sun, 12 May 2002 20:57:30 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
Message-ID: <20020512205730.A24579@averell>
In-Reply-To: <20020512203615.A12612@averell> <20020512184606.GB2105@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 08:46:06PM +0200, Axel H. Siebenwirth wrote:
> Hi Andi!
> 
> Isn't there a config option called CONFIG_EISA?
> Which is about the same as ISA?

EISA is not the same as ISA, it is a superset.

Yes there is. But it is currently not used for driver configuration,
only for some internal code. Of course if someone is motived it would
make sense to mark all EISA drivers with CONFIG_EISA too.

-Andi
