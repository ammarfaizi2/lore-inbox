Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUBPQF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbUBPQF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:05:27 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:27274 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265663AbUBPQFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:05:21 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: stty utf8
Date: 16 Feb 2004 17:10:11 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87fzdb57ks.fsf@bytesex.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216150501.GC16658@mail.shareable.org>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Trace: bytesex.org 1076947812 28498 127.0.0.1 (16 Feb 2004 16:10:12 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> 2. Terminals are not all UTF-8, and some never will be.

> ==> This problem would be very nicely solved with an additional
>     terminal flag.  We have "stty ocrnl", "onlcr", "igncr" etc. to
>     translate between terminal line endings and the unix convention of
>     LF at the end of each line.  Why not create "stty utf8" so that
>     non-UTF-8 terminals and UTF-8 terminals alike can work with a
>     Linux convention that all programs enter and display UTF-8?  It
>     would simplify a lot of things.

It's probably possible to extend luit doing that too.  luit comes with
recent xfree86 releases and does utf-8 <=> locale conversion.  Right
now it does just the opposite:  let people use non-utf8 locales in a
utf-8 xterm.

  Gerd

-- 
Es geht darum, daß ein Haufen Scriptkiddies gerade dabei sind, USENET in
Bunt neu zu erfinden, und sie derzeit einen Haufen Fehler neu machen,
die schon seit 20 Jahren nicht mehr Gegenstand der Forschung sind.
	-- Kristian Köhntopp über blogs und blogger
