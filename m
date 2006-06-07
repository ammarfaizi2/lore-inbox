Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWFGTQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWFGTQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFGTQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:16:34 -0400
Received: from mout2.freenet.de ([194.97.50.155]:13288 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932268AbWFGTQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:16:33 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Dag Arne Osvik <da@osvik.no>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Wed, 7 Jun 2006 21:16:30 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606051218.16125.jfritschi@freenet.de> <4484B001.3010503@osvik.no>
In-Reply-To: <4484B001.3010503@osvik.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606072116.30313.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 00:28, Dag Arne Osvik wrote:
> Joachim Fritschi wrote:
> > Can you give me any hint what to improve or maybe provide a suggestion on how 
> > to improve the overall readabilty.
> 
> It looks better on second reading, but I have some comments:
> 
> Remove load_s - it's needless and (slightly) confusing
Done
> There are some cases of missing ## D
Oops, fixed.
> Why semicolon after closing parenthesis in macro definitions?
Braindamage on my part.
> Try to align operands in columns
Done
> It would be nice to have some explanation of macro parameter names
Done for the non trivial stuff
> Btw, why do you keep zeroing tmp registers when you don't need to?
> 32-bit ops zero the top half of the destination register.
Again braindamage :). Fixed it according to your suggestions.

Thanks for the comments. Will post a new patches in a few minutes.

-Joachim

