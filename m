Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRK0HpS>; Tue, 27 Nov 2001 02:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRK0Hno>; Tue, 27 Nov 2001 02:43:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55559 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282843AbRK0Hmx>;
	Tue, 27 Nov 2001 02:42:53 -0500
Date: Tue, 27 Nov 2001 08:42:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127084234.V5129@suse.de>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <3C02C06A.E1389092@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C02C06A.E1389092@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26 2001, Andrew Morton wrote:
> 2: The current elevator design is downright cruel to humans in
> the presence of heavy write traffic.

max_bomb_segments logic was established to help absolutely _nothing_ a
long time ago.

I agree that the current i/o scheduler has really bad interactive
performance -- at first sight your changes looks mostly like add-on
hacks though. Arjan's priority based scheme is more promising.

-- 
Jens Axboe

