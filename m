Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbRAYKYi>; Thu, 25 Jan 2001 05:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131165AbRAYKY3>; Thu, 25 Jan 2001 05:24:29 -0500
Received: from linuxcare.com.au ([203.29.91.49]:64775 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129774AbRAYKYR>; Thu, 25 Jan 2001 05:24:17 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 25 Jan 2001 21:20:33 +1100
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010125212033.E14807@linuxcare.com>
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com> <Pine.LNX.4.30.0101240156150.3522-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101240156150.3522-100000@iq.rulez.org>; from sape@iq.rulez.org on Wed, Jan 24, 2001 at 01:58:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> No plans for samba to use sendfile? Even better make it a tux-like module?
> (that would enable Netware-Linux like performance with the standard
> kernel... would be cool afterall ;)

I have patches for samba to do sendfile. Making a tux module does not make
sense to me, especially since we are nowhere near the limits of samba in
userspace. Once userspace samba can run no faster, then we should think
about other options.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
