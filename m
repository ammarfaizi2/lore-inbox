Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbQLVHbb>; Fri, 22 Dec 2000 02:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131884AbQLVHbV>; Fri, 22 Dec 2000 02:31:21 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:62734 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S131749AbQLVHbF>;
	Fri, 22 Dec 2000 02:31:05 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012220700.XAA09901@pobox.com>
Subject: Re: recommended gcc compiler version
To: reaster@comptechnews.com (Robert B. Easter)
Date: Thu, 21 Dec 2000 23:00:46 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <0012212320430F.02217@comptechnews> from "Robert B. Easter" at Dec 21, 2000 11:20:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert B. Easter wrote:
> This is a newbie question, but what are the recommended gcc compiler versions 
> for compiling,

This is discussed in the Documentation/Changes file, in a given kernel's
source. Brief summaries follow (which assume you're using an x86 CPU).

> Linux 2.2.18?

gcc 2.7.2.3 is safest, but egcs 1.1.2 should be safe even for
mission-critical stuff. gcc 2.95.2 seems to work for many people, but
isn't necessarily safe.

> Linux 2.4.0?

egcs 1.1.2 is the safe choice, but gcc 2.95.2 seems to work. gcc 2.7.2.3
miscompiles 2.4 more often than not, so 2.4 has a preprocessor check that
stops any attempts to compile it with 2.7.2.3.

-Barry K. Nathan <barryn@pobox.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
