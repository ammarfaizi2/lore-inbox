Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313630AbSDPIPn>; Tue, 16 Apr 2002 04:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313632AbSDPIPm>; Tue, 16 Apr 2002 04:15:42 -0400
Received: from holomorphy.com ([66.224.33.161]:57488 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313630AbSDPIPm>;
	Tue, 16 Apr 2002 04:15:42 -0400
Date: Tue, 16 Apr 2002 01:14:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Olaf Fraczyk <olaf@navi.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416081453.GP21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:47:48AM +0200, Olaf Fraczyk wrote:
> Hi,
> I would like to know why exactly this value was choosen.
> Is it safe to change it to eg. 1024? Will it break anything?
> What else should I change to get it working:
> CLOCKS_PER_SEC?
> Please CC me.
> Regards,
> Olaf Fraczyk

I tried a few times running with HZ == 1024 for some testing (or I guess
just to see what happened). I didn't see any problems, even without the
obscure CLOCKS_PER_SEC ELF business.


Cheers,
Bill
