Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270170AbRHGJyj>; Tue, 7 Aug 2001 05:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270171AbRHGJy3>; Tue, 7 Aug 2001 05:54:29 -0400
Received: from snoopy.apana.org.au ([202.12.87.129]:12038 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S270166AbRHGJyR>; Tue, 7 Aug 2001 05:54:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
	<Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
	<15215.27296.959612.765065@localhost.efn.org>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 07 Aug 2001 19:52:23 +1000
In-Reply-To: <15215.27296.959612.765065@localhost.efn.org>
Message-ID: <84zo9ci4dk.fsf@scrooge.chocbit.org.au>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Steve" == Steve VanDevender <stevev@efn.org> writes:

    Steve> The obvious approach to me would to generate a random
    Steve> session key at boot time and use that for
    Steve> encrypting/decrypting swap pages.  If the machine is
    Steve> unplugged and the disk pulled out, then the swap area on
    Steve> that disk could not be recovered the attacker, who

Example: disk is faulty and will no longer work. How do you guarantee
that nobody will be able to read it after you toss it out OR return it
to the manufacturer to claim for warranty?

(of course, encrypting swap space is only part of the solution, here
you need to encrypt everything).
-- 
Brian May <bam@snoopy.apana.org.au>
