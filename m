Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUCaWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUCaWdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:33:16 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:38569 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262599AbUCaWdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:33:07 -0500
From: David Lang <david.lang@digitalinsight.com>
To: walt <wa1ter@myrealbox.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Date: Wed, 31 Mar 2004 14:32:46 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Broadcom gigabit solution for Jeff.
In-Reply-To: <4058DBC9.5050301@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0403311431070.22377@dlang.diginsite.com>
References: <40578C04.3070202@myrealbox.com> <20040316174511.3003f880.davem@redhat.com>
 <405872E1.8020109@myrealbox.com> <20040317102412.44c64caf.davem@redhat.com>
 <4058DBC9.5050301@myrealbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem with 5704 rev 3 where I need to transmit
something over the card before it wakes up after boot.

looking at the traffic light, I see lots of traffic during the boot, until
the driver initializes, at which time nothing is received until I initiate
traffic out the card.

David Lang

On Wed, 17 Mar 2004, walt wrote:

> Date: Wed, 17 Mar 2004 15:14:17 -0800
> From: walt <wa1ter@myrealbox.com>
> To: David S. Miller <davem@redhat.com>
> Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
> Subject: Re: Broadcom gigabit solution for Jeff.
>
> David S. Miller wrote:
> > Hmmm, I think the common denominator is that all the people still
> > seeing this problem have 5704 chips...
>
> Well, not quite all -- mine is a 5702 rev2  ;-)
>
>
> >  I'll look into this... thanks.
>
> And thanks to you, too.  If I can test patches or do any debugging please
> let me know.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
