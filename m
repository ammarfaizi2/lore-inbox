Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263928AbRFHI0J>; Fri, 8 Jun 2001 04:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbRFHIZu>; Fri, 8 Jun 2001 04:25:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10880 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263928AbRFHIZl>;
	Fri, 8 Jun 2001 04:25:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15136.35839.188306.480471@pizda.ninka.net>
Date: Fri, 8 Jun 2001 01:25:35 -0700 (PDT)
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Bug in nonlocal-bind (transparent proxy)?
In-Reply-To: <20010608110237.A1911@leeor.math.technion.ac.il>
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il>
	<20010608014443.A28407@saw.sw.com.sg>
	<20010608110237.A1911@leeor.math.technion.ac.il>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nadav Har'El writes:
 > I don't understand what is willful: why does the ip_nonlocal_bind sysctl
 > exist if it doesn't help? Getting bind() to work (which is what
 > ip_nonlocal_bind does) but later not being able to connect() this socket
 > isn't very useful...

ip_nonlocal_bind is meant for another purpose all together.
It allows you to bind to IP addresses which aren't configured
up at the moment.

It's meant for dial-on-demand type situations, nothing more.

Later,
David S. Miller
davem@redhat.com
