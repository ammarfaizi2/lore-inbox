Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRGaTlM>; Tue, 31 Jul 2001 15:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269439AbRGaTlC>; Tue, 31 Jul 2001 15:41:02 -0400
Received: from weta.f00f.org ([203.167.249.89]:49286 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269437AbRGaTk4>;
	Tue, 31 Jul 2001 15:40:56 -0400
Date: Wed, 1 Aug 2001 07:41:32 +1200
From: Chris Wedgwood <cw@f00f.org>
To: kuznet@ms2.inr.ac.ru
Cc: therapy@endorphin.org, pekkas@netcore.fi, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: missing icmp errors for udp packets
Message-ID: <20010801074132.G8228@weta.f00f.org>
In-Reply-To: <200107311937.XAA11313@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107311937.XAA11313@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 11:37:06PM +0400, kuznet@ms2.inr.ac.ru wrote:

    To bind all of them together?

Sure... why not?

The kernel normally does one of two things

   --- multiplex hardware resources for applications

or

   --- cheap router thing

"really good ping responder" is a pointless purpose.

    Then kernel must be shipped out without rate-limiting enabled by
    default, that's problem.

I guess I missed something.  That doesn't seem like a problem to
me... and if you need to ship with a rate by default, then ship with a
very-high rate.  I've never managed to respond to more than 60,000
ICMP packets/second, so I suggest 60,001.




  --cw
