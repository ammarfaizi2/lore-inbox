Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUHUM1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUHUM1T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUHUM1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:27:19 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:33424 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264639AbUHUM1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:27:18 -0400
Date: Sat, 21 Aug 2004 14:25:15 +0200 (CEST)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists@free.fr>
X-X-Sender: peter@gaston.free.fr
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] idle ide disk on resume
In-Reply-To: <fa.e71k2cf.qladil@ifi.uio.no>
Message-ID: <Pine.LNX.4.58.0408211419040.973@gaston.free.fr>
References: <fa.e71k2cf.qladil@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Jens Axboe wrote:

> I need this patch to survive suspend on my powerbook, if the drive is
> sleeping when suspend is entered. Otherwise it freezes on resume when it
> tries to read from the drive.

Hello,
unfortunately, with this patch the disk always wakes up when resuming (from
ACPI S1), even if it does not need to.
Could it be possible, to get previous behaviour, that is keeping disk
sleeping when resuming?
Kind regards, Peter

-- 
http://pmrb.free.fr/contact/
_____________________________________
FilmSearch engine: http://f-s.sf.net/
