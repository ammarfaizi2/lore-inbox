Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWGROKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWGROKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWGROKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:10:45 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:35575 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932207AbWGROKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:10:43 -0400
Subject: Re: [patch 5/6] s390: .align 4096 statements in head.S
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
In-Reply-To: <Pine.LNX.4.61.0607180929340.12146@chaos.analogic.com>
References: <20060718115622.GE20884@skybase>
	 <Pine.LNX.4.61.0607180825240.11870@chaos.analogic.com>
	 <1153227104.9681.2.camel@localhost>
	 <Pine.LNX.4.61.0607180929340.12146@chaos.analogic.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 18 Jul 2006 16:10:42 +0200
Message-Id: <1153231842.13773.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 09:33 -0400, linux-os (Dick Johnson) wrote:
> >> It looks like
> >> you wrote something in 'C' and tried to use its assembly code.
> Yes, I know exactly what I am saying and I mentioned the reference
> to 'C' because the ".Labels" start with ".L" as 'C' does it. Humans
> generally use human-readable names.

You postulated that we have converted some C code and tried to use the
resulting assembly code. We did not. Do not make assumptions.

> If you BOTHERED to read the rest of the email, I instructed one
> how to use the assembler 'gas' so I certainly know that it is not
> 'C'. Thank you.

Thank you very much for your kind instruction how to use the assembler.
The .fill statements are there for the definition of the SCCB that finds
out about the memory size of the machine. An SCCB has a peculiar format,
to make it independent of the location the .fill statements do make
sense, even if they fill up with zeroes.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


