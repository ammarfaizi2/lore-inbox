Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264970AbRFZPFg>; Tue, 26 Jun 2001 11:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264971AbRFZPFH>; Tue, 26 Jun 2001 11:05:07 -0400
Received: from [203.143.19.4] ([203.143.19.4]:50442 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S264970AbRFZPE7>;
	Tue, 26 Jun 2001 11:04:59 -0400
Date: Tue, 26 Jun 2001 21:04:12 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
Message-ID: <20010626210412.B366@bee.lk>
In-Reply-To: <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl> <20010626004149.A3310@storm.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010626004149.A3310@storm.local>; from andreas.bombe@munich.netsurf.de on Tue, Jun 26, 2001 at 12:41:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 12:41:49AM +0200, Andreas Bombe wrote:
> 
> But the first example contains three newlines, the second just one.  A
> thing to keep in mind when going around fixing these multi line strings,
> explicit newlines have to be added.

Some code contains very long lines (around 150 characters per line) and others
tend to limit lines to 72-80 lines.

And strings have been broken in the middle _just_ to keep the lines short, and
sometimes without caring about the additional newline. In such cases, either,
the lines should be merged or a backslash should be added to the end(s) of the
line(s).

Please refer to my patch (GCC v3 warning fixes #1) for examples.

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.6-pre5)

Journalism is literature in a hurry.
		-- Matthew Arnold

