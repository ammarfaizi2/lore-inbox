Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274114AbRIXSKh>; Mon, 24 Sep 2001 14:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274113AbRIXSK0>; Mon, 24 Sep 2001 14:10:26 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:41222 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S274110AbRIXSKP>; Mon, 24 Sep 2001 14:10:15 -0400
Date: Mon, 24 Sep 2001 19:10:39 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules
Message-ID: <20010924191038.A76887@compsoc.man.ac.uk>
In-Reply-To: <27975.1001164529@ocs3.intra.ocs.com.au> <3BAF74B8.6070102@interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAF74B8.6070102@interactivesi.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 01:00:24PM -0500, Timur Tabi wrote:

> The reason I ask is because I'm working on a closed-source (unfortunately) 
> driver for Linux, and I'd really like to make it behave as well as possible.

add to your module code :

MODULE_LICENSE("TabiPL");

(or whatever it is).

That way the kernel maintainers can ignore any bugs reported with your module
loaded easily.

regards
john

-- 
"Khendon's Law: If the same point is made twice by the same person,
 the thread is over."
