Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRGaTeW>; Tue, 31 Jul 2001 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRGaTeO>; Tue, 31 Jul 2001 15:34:14 -0400
Received: from weta.f00f.org ([203.167.249.89]:46726 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269436AbRGaTeA>;
	Tue, 31 Jul 2001 15:34:00 -0400
Date: Wed, 1 Aug 2001 07:34:41 +1200
From: Chris Wedgwood <cw@f00f.org>
To: kuznet@ms2.inr.ac.ru
Cc: therapy@endorphin.org, pekkas@netcore.fi, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: missing icmp errors for udp packets
Message-ID: <20010801073441.E8228@weta.f00f.org>
In-Reply-To: <200107311925.XAA11038@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107311925.XAA11038@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 11:25:50PM +0400, kuznet@ms2.inr.ac.ru wrote:

    Anyway, it is clear that echos are to be limited differently of
    errors.

Even then I wonder if it is worth the code.  If you are rate-limiting,
who cares if drop the odd echo/reply?

ICMP echo/reply is a useful diagnostic tool --- but on the internet as
we have it today, its limitations need to be understood by the user :)



  --cw
