Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTKMPXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTKMPXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:23:31 -0500
Received: from ns.suse.de ([195.135.220.2]:970 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264314AbTKMPX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:23:27 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
	<3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random>
	<03Nov13.095622cet.122129@mojo.it.advantest.de>
	<20031113145301.GJ1649@x30.random>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Did we bring enough BEEF JERKY?
Date: Thu, 13 Nov 2003 16:23:24 +0100
In-Reply-To: <20031113145301.GJ1649@x30.random> (Andrea Arcangeli's message
 of "Thu, 13 Nov 2003 15:53:01 +0100")
Message-ID: <jen0b047ir.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Wed, Nov 12, 2003 at 10:35:22PM +0100, Benoit Poulot-Cazajous wrote:
>> Andrea Arcangeli <andrea@suse.de> writes:
>> 
>> > the usual problem, and the reason we need a sequence number (increased
>> > before and after the repo update). A file lock not.
>> 
>> Or a file that contains md5sums of the other files in the tree. 
>> After the rsync, you recompute the md5sums file, and if it does not match,
>> rsync again. As a bonus feature, the md5sums file can be pgp-signed.
>
> agreed, this would work too and it has the advantage of working with the
> mirrors too as far as the per-file updates are atomic (should always be
> the case). This has the only disavanage of forcing the client and the
> server to read all file contents (I normally don't rsync with -c).

This is not necessary, you only need to recompute the md5sums of changed
files.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
