Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSAIRhG>; Wed, 9 Jan 2002 12:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288902AbSAIRg4>; Wed, 9 Jan 2002 12:36:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45839 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288845AbSAIRgu>; Wed, 9 Jan 2002 12:36:50 -0500
Subject: Re: Where's all my memory going?
To: matt@bodgit-n-scarper.com (Matt Dainty)
Date: Wed, 9 Jan 2002 17:47:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020109173633.A26559@mould.bodgit-n-scarper.com> from "Matt Dainty" at Jan 09, 2002 05:36:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OMpF-0001pj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, over time, (30-45 minutes), more and more memory seems to just
> disappear from the system until it looks like this, (note that swap is
> hardly ever touched):

I don't see any disappearing memory. Remember that Linux will intentionally
keep memory filled with cache pages when it is possible. The rest I can't
help with - Im not familiar enough with qmail to know what limits it places
internally or where the points it and/or the kernel might interact to
cause bottlenecks are 
