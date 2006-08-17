Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWHQI7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWHQI7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWHQI7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:59:30 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36514 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932217AbWHQI73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:59:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17636.11747.89849.992490@alkaid.it.uu.se>
Date: Thu, 17 Aug 2006 10:50:43 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <w@1wt.eu>,
       Adrian Bunk <bunk@stusta.de>, Willy Tarreau <wtarreau@hera.kernel.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
In-Reply-To: <44E42A4C.4040100@domdv.de>
References: <20060816223633.GA3421@hera.kernel.org>
	<20060816235459.GM7813@stusta.de>
	<20060817051616.GB13878@1wt.eu>
	<1155797331.4494.17.camel@laptopd505.fenrus.org>
	<44E42A4C.4040100@domdv.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz writes:
 > Arjan van de Ven wrote:
 > > But maybe it's worth doing a user survey to find out what the users of
 > > 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
 > > people who use enterprise distro kernels don't count for this since
 > > they'll not go to a newer released 2.4 anyway)
 > 
 > Currently I'm working with ARM based embedded systems. I prefer 2.4
 > kernels to 2.6 as they are smaller thus leaving more flash for jffs2.
 > Not speaking of the kernel a gcc 4.1.1 compile of code for a LPC2103
 > resulted in a clearly smaller binary as the same compile with gcc 3.4.
 > Thus I really would like to be able to use gcc 4.x with 2.4 kernels.
 > There are even kernel miscompiles with gcc 3.4 that might be fixed with
 > gcc 4 (one has to try).

I've done a fair amount of ARM user-space hacking recently, and the
number of bug fixes one has to apply to gcc-3.3 or gcc-3.4 to make it
even semi-correct on ARM is scary. Since these versions aren't supported
any more, being able to use newer, hopefully less buggy, and _supported_
gcc versions is clearly beneficial.

Of course, this is not an issue for x86 users.
