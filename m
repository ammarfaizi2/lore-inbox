Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbRFYJRb>; Mon, 25 Jun 2001 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbRFYJRV>; Mon, 25 Jun 2001 05:17:21 -0400
Received: from pD951F7B2.dip.t-dialin.net ([217.81.247.178]:58884 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S262856AbRFYJRA>; Mon, 25 Jun 2001 05:17:00 -0400
Date: Mon, 25 Jun 2001 11:16:57 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC3.0 Produce REALLY slower code!
Message-ID: <20010625111657.C13348@emma1.emma.line.org>
Mail-Followup-To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Alexander V. Bilichenko wrote:

> Hello All!
> Some tests that I have recently check out.
> kernel compiled with 3.0 (2.4.5) function call: 1000000 iteration. 3% slower
> than 2.95.
> test example - hash table add/remove - 4% slower (compiled both
> with -O2 -march=i686).
> Why have this version been released?

Because it comes with various other improvements, among them better
error detection, better C++ support, integrated GCJ (but regretfully
still without Ada 95), to name a few reasons.

3% to 4% loss in a first release of a new major release is not a big
deal, although I found similar results on leafnode's texpire.
However, 3% do not warrant me spending my time complaining. Maybe some
optimization is missing, maybe other operations than the ones you
checked are faster. So there.

You might run an entire benchmark suite and report back, tough. :-)
