Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRB0AOQ>; Mon, 26 Feb 2001 19:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRB0AOE>; Mon, 26 Feb 2001 19:14:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48799 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129306AbRB0ANu>;
	Mon, 26 Feb 2001 19:13:50 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.61544.121517.514618@pizda.ninka.net>
Date: Mon, 26 Feb 2001 16:10:16 -0800 (PST)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9AEFAF.1DC89A8A@mandrakesoft.com>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
	<15002.60104.350394.893905@pizda.ninka.net>
	<3A9AEFAF.1DC89A8A@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > I only want to know if more are coming, not actually pass multiples..

Ok, then my only concern is that the path from "I know more is coming"
down to hard_start_xmit invocation is long.  It would mean passing a
new piece of state a long distance inside the stack from SKB origin to
device.

Later,
David S. Miller
davem@redhat.com
