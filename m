Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRG1XQC>; Sat, 28 Jul 2001 19:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbRG1XPx>; Sat, 28 Jul 2001 19:15:53 -0400
Received: from pD9E1EFED.dip.t-dialin.net ([217.225.239.237]:8461 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267233AbRG1XPq>; Sat, 28 Jul 2001 19:15:46 -0400
Date: Sun, 29 Jul 2001 01:15:52 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Lawrence Greenfield <leg+@andrew.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729011552.B9350@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Lawrence Greenfield <leg+@andrew.cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200107271624.f6RGOu8U010566@acap-dev.nas.cmu.edu> <Pine.LNX.4.33L.0107271356050.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107271356050.5582-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Rik van Riel wrote:

> The stuff you people seem to insist on, however, most
> definately isn't part of the defined set of semantics.

And even if it's "inherited wisdom", you cannot simply tell those people
"don't rely on that" if - as claimed - you can't even force a link() to
disk.

> If you believe otherwise, feel free to point out the
> relevant sections in POSIX / SuS / ...

The standard is only useful if it specifies how to get data safely on
disk - it is quite explicit for fsync(), but you evidently cannot
fsync() a link().

-- 
Matthias Andree
