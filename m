Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIQJH>; Tue, 9 Jan 2001 11:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIQI6>; Tue, 9 Jan 2001 11:08:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129226AbRAIQIu>;
	Tue, 9 Jan 2001 11:08:50 -0500
Date: Tue, 9 Jan 2001 16:05:11 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
Message-ID: <20010109160511.I9321@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com> <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva> <20010109140932.E4284@redhat.com> <qwwhf387p4s.fsf@sap.com> <20010109153119.G9321@redhat.com> <qwwd7dw7mrd.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <qwwd7dw7mrd.fsf@sap.com>; from cr@sap.com on Tue, Jan 09, 2001 at 04:45:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 04:45:10PM +0100, Christoph Rohland wrote:
> Hi Stephen,
> 
> AFAIU mlock'ed pages would never get deactivated since the ptes do not
> get dropped.

D'oh, right --- so can't you lock a segment just by bumping page_count
on its pages?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
