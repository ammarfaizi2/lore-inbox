Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272571AbTHFV2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272570AbTHFV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:28:50 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:56750
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272571AbTHFV20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:28:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Thu, 7 Aug 2003 07:33:38 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <3F31741F.30200@techsource.com>
In-Reply-To: <3F31741F.30200@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308070733.38135.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For this, I reiterate my suggestion to intentionally over-shoot the
> mark.  If you do it right, a process will run an inappropriate length of
> time only every other time slice until the oscillation dies down.

Your thoughts are fine, and to some degree I do what you're proscribing, but I 
take into account the behaviour of real processes in the real world and their 
effect on scheduling fairness.

Con

