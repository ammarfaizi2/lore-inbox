Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDSRpT>; Thu, 19 Apr 2001 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRDSRpB>; Thu, 19 Apr 2001 13:45:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131614AbRDSRow>;
	Thu, 19 Apr 2001 13:44:52 -0400
Date: Thu, 19 Apr 2001 18:44:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1
Message-ID: <20010419184444.A3111@flint.arm.linux.org.uk>
In-Reply-To: <20010419131944.A3049@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419131944.A3049@thyrsus.com>; from esr@thyrsus.com on Thu, Apr 19, 2001 at 01:19:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 01:19:44PM -0400, Eric S. Raymond wrote:
> The following patch cleans dead symbols out of the defconfigs in the 2.4.4pre4
> source tree.  It corrects a typo involving CONFIG_GEN_RTC.  Another typo
> involving CONFIG_SOUND_YMPCI doesn't need to be corrected, as the symbol
> is never set in these files.

As I said previously, please don't eliminate the ones on arch/arm -
you'll prevent me from sending a patch to Alan without a _lot_ more
work.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

