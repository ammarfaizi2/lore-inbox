Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275399AbRIZSBb>; Wed, 26 Sep 2001 14:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275391AbRIZSBM>; Wed, 26 Sep 2001 14:01:12 -0400
Received: from borg.org ([208.218.135.231]:4101 "HELO borg.org")
	by vger.kernel.org with SMTP id <S275392AbRIZSBF>;
	Wed, 26 Sep 2001 14:01:05 -0400
Date: Wed, 26 Sep 2001 14:01:30 -0400
From: Kent Borg <kentborg@borg.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Re: 2.4.9-ac15 painfully sluggish
Message-ID: <20010926140130.A32255@borg.org>
In-Reply-To: <Pine.LNX.4.33.0109251819520.1401-100000@pau.intranet.ct> <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Sep 25, 2001 at 04:32:13PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 04:32:13PM -0300, Rik van Riel wrote:
> I've made a small patch to 2.4.9-ac15 which should make
> page_launder() smoother, make some (very minor) tweaks
> to page aging and updates various comments in vmscan.c

Works for me.  I have the premption patch turned on.

On a 192 MB PIII laptop running at 500 MHz I have two X sessions
running, and have opened a zillion application windows on each,
including over a dozen Netscape windows, some Mozilla's, a couple
emacs's, a kernel compile, Staroffice.  About every app I can
immediately think of.  I haven't tried malloc-ing a ton of memory, but
this contrived real-world test works.

Swap is at 238 MB.  Lower than I would have expected, but that doesn't
mean I know anything.

Switching between X sessions just took near 10-seconds going, and only
about 5-seconds coming back.  Switching in Staroffice is painful, but
generally the responsiveness feels quite nice.

I like it.  Thanks,

-kb, the Kent who will be staying with 2.4.9-ac15, plus preemption
patch, plus this patch--once he figures out how to close all those
windows.
