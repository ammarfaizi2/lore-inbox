Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263502AbREYCza>; Thu, 24 May 2001 22:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263501AbREYCzU>; Thu, 24 May 2001 22:55:20 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:1758 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263500AbREYCzE>;
	Thu, 24 May 2001 22:55:04 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105250254.TAA00857@csl.Stanford.EDU>
Subject: Re: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 24 May 2001 19:54:56 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1534C7-0005lu-00@the-village.bc.nu> from "Alan Cox" at May 25, 2001 12:07:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disagree
> 
> > 	ahc = ahc_alloc(NULL, name);
> 
> ahc_alloc frees name on error

Wow.  That would have been a really nasty "fix."  Sorry about that -- the
name "ahc_alloc" is a little counter-intuitive ;-)

Thanks for the quick feedback.

Dawson
