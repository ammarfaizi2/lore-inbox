Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbREaWJl>; Thu, 31 May 2001 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbREaWJb>; Thu, 31 May 2001 18:09:31 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:23533 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263251AbREaWJZ>;
	Thu, 31 May 2001 18:09:25 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105312206.PAA16024@csl.Stanford.EDU>
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Thu, 31 May 2001 15:06:02 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105312325250.4527-100000@vaio> from "Kai Germaschewski" at May 31, 2001 11:38:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are actual (performance) bugs.
> Patch is appended.

Thanks for the quick feedback!

> BTW: I don't if you did so already, but if you extended the checker to
> find functions which are only called from __init functions, but not
> marked __init themselves, you'd most likely find lots more performance
> bugs of this kind.

I haven't hacked this in --- I was waiting to get a feel for how
important the checker was before spending too much time on it.  I agree
with your intuition that there would be a lot of these cases ;-)
