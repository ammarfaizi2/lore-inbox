Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGXAFi>; Mon, 23 Jul 2001 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRGXAFS>; Mon, 23 Jul 2001 20:05:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36827 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265402AbRGXAFK>;
	Mon, 23 Jul 2001 20:05:10 -0400
Message-ID: <3B5CBBDD.61365F56@mandrakesoft.com>
Date: Mon, 23 Jul 2001 20:05:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Friedley <saai@swbell.net>, linux-kernel@vger.kernel.org
Subject: Re: pppoe patch in 2.4.7 results - still problem
In-Reply-To: <000901c112d6$a1a30000$0200a8c0@loki> <15196.46734.280781.653712@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"David S. Miller" wrote:
> Andrew Friedley writes:
>  > In response to the pppoe patch to try to fix panics with pppoe and smp:
>  > When running napster/napigator from a windows machine on my LAN, the router
>  > running 2.4.7 still panics.  It has not been long enough to tell if the
>  > "random" panics have been fixed for sure, but so far, so good - 1 day, 4
>  > hour uptime right now.  Here is a paste of a napster-induced panic with
>  > kernel 2.4.7 followed by the ksymoops output.

> This looks like perhaps a specific problem with the 8139too
> patches to support single-copy checksumming.  I could be wrong,
> but it looks nothing like the pppoe OOPS traces.

via-rhine is the only user of skb_copy_and_csum_dev at present; but the
point still stands.  (I am holding off on that 8139too patch, for just a
bit, to stabilize the driver WRT bugs)

	Jeff


-- 
Jeff Garzik      | "I use Mandrake Linux for the same reason I turn
Building 1024    |  the light switch on and off 17 times before leaving
MandrakeSoft     |  the room.... If I don't my family will die."
                 |            -- slashdot.org comment
