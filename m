Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285432AbRLGIsf>; Fri, 7 Dec 2001 03:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285434AbRLGIsU>; Fri, 7 Dec 2001 03:48:20 -0500
Received: from holomorphy.com ([216.36.33.161]:40576 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285432AbRLGIr5>;
	Fri, 7 Dec 2001 03:47:57 -0500
Date: Fri, 7 Dec 2001 00:47:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: vma->vm_end > 0x60000000
Message-ID: <20011207004754.A903@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10010311645420.400-100000@cassiopeia.home> <20011206191734.B818@holomorphy.com> <jevgfj8m5z.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <jevgfj8m5z.fsf@sykes.suse.de>; from schwab@suse.de on Fri, Dec 07, 2001 at 09:33:12AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> I think this is an old x86 load address for an ELF interpreter.

On Fri, Dec 07, 2001 at 09:33:12AM +0100, Andreas Schwab wrote:
> No, it is a leftover from the a.out times.  IMHO it should be removed
> completely.  "Library pages" has no meaning for ELF.

Enlightening. Are you willing to accept changes to the format?
Some other changes to this function have also been suggested.

I'll follow up with a patch that unconditionally returns 0 for
library pages.


Cheers,
Bill


