Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283002AbRK1CMp>; Tue, 27 Nov 2001 21:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281832AbRK1CMe>; Tue, 27 Nov 2001 21:12:34 -0500
Received: from waste.org ([209.173.204.2]:11191 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281831AbRK1CMZ>;
	Tue, 27 Nov 2001 21:12:25 -0500
Date: Tue, 27 Nov 2001 20:12:21 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: J Sloan <jjs@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: heads-up: preempt kernel and tux NO-GO
In-Reply-To: <3C043B11.2FA17A19@pobox.com>
Message-ID: <Pine.LNX.4.40.0111272007070.9338-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, J Sloan wrote:

> I have been looking into the tux2 webserver -
> Man, what a thing of beauty. A web benchmark
> that sends the load on the web server to 150
> when running apache results in a load average
> of  maybe 2 when running tux, and much faster
> results to boot - anyway, I digress....

Loadavg isn't much of a measure here, it's a measure of the length of the
runnable queue. If you've only got two processes because your server has a
thread per processor, then yes, you'll see lower loadavg, but not lower
load. A real measure would look at idle percentage and throughput.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

