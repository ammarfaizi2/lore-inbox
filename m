Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbQLCVAE>; Sun, 3 Dec 2000 16:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbQLCU7y>; Sun, 3 Dec 2000 15:59:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19212 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131100AbQLCU7n>;
	Sun, 3 Dec 2000 15:59:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: Your message of "Sun, 03 Dec 2000 07:43:01 MDT."
             <Pine.LNX.3.96.1001203074055.23089B-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2000 07:29:10 +1100
Message-ID: <4778.975875350@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000 07:43:01 -0600 (CST), 
Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> wrote:
>On Sun, 3 Dec 2000, Keith Owens wrote:
>> If you go down this path, please add a standard performance monitoring
>> method to query the current capacity of an interface.
>Well, ethtool interface supports reporting media selection as well as
>[re]setting media setting.  I dunno if we could report what capacity
>an interface is handling without adding code to hot paths...

You calculate the capacity during ifconfig up or during speed change.
That is not on the hot path.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
