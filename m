Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTHWMS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTHWMSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:18:25 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:49573
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263322AbTHWMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:16:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>,
       Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: Re: [PATCH]O18.1int
Date: Sat, 23 Aug 2003 22:22:30 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308231555.24530.kernel@kolivas.org> <200308231108.48053.schlicht@uni-mannheim.de> <3F47317D.3030802@cyberone.com.au>
In-Reply-To: <3F47317D.3030802@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308232222.30527.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 19:18, Nick Piggin wrote:
> Hi
> I don't know what is preferred on lkml, but I dislike mixing booleans
> and integer arithmetic.
>
> if (!LOW_CREDIT(prev))
>     prev->interactive_credit--;
>
> Easier to read IMO.

I agree. I only mixed them because of my (perhaps false) belief that it's less 
of a hit not having another if.. branch point. Then again today's compilers 
probably optimise it out anyway.

Con

