Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAMNwD>; Sat, 13 Jan 2001 08:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAMNvx>; Sat, 13 Jan 2001 08:51:53 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:5249 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S129790AbRAMNvg>;
	Sat, 13 Jan 2001 08:51:36 -0500
Date: Sat, 13 Jan 2001 05:46:29 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.linux.org
Subject: Re: khttpd beats boa with persistent patch
In-Reply-To: <Pine.LNX.4.30.0101122343220.30402-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.21.0101130545030.3390-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, dean gaudet wrote:

> anyhow a real network benchmark might show that kHTTPd latency is actually
> not as broken as this one indicates.  i'd however really hesitate to call
> this a win.

Well as Arjan says: khttpd starves userspace and that might cause the
latency. I dont have the ability to really test it over a 100mbs link.

> btw is your CPU slow or something?  'cause istr getting numbers at least
> this good from apache across localhost several years ago even under
> 2.0.x... and boa and khttpd should both beat apache in this.

Its a Cyrix 150. So yes.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
