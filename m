Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDUC2>; Sat, 4 Nov 2000 15:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQKDUCS>; Sat, 4 Nov 2000 15:02:18 -0500
Received: from hera.cwi.nl ([192.16.191.1]:48007 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129057AbQKDUCB>;
	Sat, 4 Nov 2000 15:02:01 -0500
Date: Sat, 4 Nov 2000 21:01:58 +0100
From: Andries Brouwer <aeb@veritas.com>
To: aprasad@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes> 2^15
Message-ID: <20001104210158.A13496@veritas.com>
In-Reply-To: <CA25698D.00608C13.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <CA25698D.00608C13.00@d73mta05.au.ibm.com>; from aprasad@in.ibm.com on Sat, Nov 04, 2000 at 07:27:58PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 07:27:58PM +0530, aprasad@in.ibm.com wrote:

> after reaching process count something around 30568, processes start
> getting pid from start, which ever is the first free entry slot in process
> table. that means we can't have simultaneously more than roughly 2^15
> processes?
> am i correct?

Yes.
(If that displeases you I can give you the trivial patch.
However, you really need some awesome machine before it
becomes reasonable to run that many processes.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
