Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTLKHXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTLKHXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:23:35 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:10884 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264471AbTLKHXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:23:33 -0500
Date: Wed, 10 Dec 2003 23:22:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ed Sweetman <ed.sweetman@wmich.edu>, Nick Piggin <piggin@cyberone.com.au>,
       Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <1293860000.1071127373@[10.10.2.4]>
In-Reply-To: <20031211071937.GA8039@holomorphy.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <1289530000.1071126517@[10.10.2.4]> <20031211071937.GA8039@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> You're probably thinking of 2:2 split patches.
>>> 2:2 splits are at least technically ABI violations, which is probably
>>> why this isn't merged etc. Applications sensitive to it are uncommon.
>>> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
>>> top of the process address space.
> 
> On Wed, Dec 10, 2003 at 11:08:38PM -0800, Martin J. Bligh wrote:
>> You mean like we place the stack in the "ABI compliant place"? 
>> Yeah, right ;-)
> 
> No specific address is ever cited as a requirement for stack placement;
> stack immediately below text is merely given as a "typical arrangement".
> i.e. "Although applications may control their memory assignments, the
> typical arrangement appears below: [diagram and other bits]" It then
> goes on to say, "Processes, therefore, shount _not_ depend on finding
> their stack at a particular virtual address."
> 
> The process address space boundary is, however, stated as a requirement:
> "the reserved area shall not consume more than 1GB of the address space."

;-)

OK, fair enough ... it doesn't actually break anything though ;-)

m.

