Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272401AbTHEDPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272403AbTHEDOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:14:35 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7579
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272401AbTHEDNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:13:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 13:18:47 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au>
In-Reply-To: <3F2F149F.1020201@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051318.47464.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
> No, this still special-cases the uninterruptible sleep. Why is this
> needed? What is being worked around? There is probably a way to
> attack the cause of the problem.

Footnote: I was thinking of using this to also _elevate_ the dynamic priority 
of tasks waking from interruptible sleep as well which may help throughput.

Con

