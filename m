Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282852AbRK0IA0>; Tue, 27 Nov 2001 03:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282854AbRK0IAS>; Tue, 27 Nov 2001 03:00:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56568
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282851AbRK0H7C>; Tue, 27 Nov 2001 02:59:02 -0500
Date: Mon, 26 Nov 2001 23:58:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011126235853.A9391@mikef-linux.matchmail.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@zip.com.au>,
	"Nathan G. Grennan" <ngrennan@okcforum.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <3C02C06A.E1389092@zip.com.au> <20011127084234.V5129@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127084234.V5129@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 08:42:34AM +0100, Jens Axboe wrote:
> On Mon, Nov 26 2001, Andrew Morton wrote:
> > 2: The current elevator design is downright cruel to humans in
> > the presence of heavy write traffic.
> 
> max_bomb_segments logic was established to help absolutely _nothing_ a
> long time ago.
> 
> I agree that the current i/o scheduler has really bad interactive
> performance -- at first sight your changes looks mostly like add-on
> hacks though. Arjan's priority based scheme is more promising.
> 

Based on pid priority or niceness?
