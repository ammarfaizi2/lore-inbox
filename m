Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRCBKhf>; Fri, 2 Mar 2001 05:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRCBKh0>; Fri, 2 Mar 2001 05:37:26 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:58884 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S130392AbRCBKhT>;
	Fri, 2 Mar 2001 05:37:19 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 10:17:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>, linux-kernel@vger.kernel.org
Subject: Re: negative mod use count
Message-ID: <20010302101741.B21799@flint.arm.linux.org.uk>
In-Reply-To: <200102281958.UAA13226@falcon.etf.bg.ac.yu> <Pine.LNX.4.21.0103011653340.8542-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103011653340.8542-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Thu, Mar 01, 2001 at 04:55:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 04:55:30PM -0800, Dr. Kelsey Hudson wrote:
> On Wed, 28 Feb 2001, Boris Dragovic wrote:
> > what does negative module use count mean?
> 
> That means that there's a bug in someone's driver.

Not necessarily.  Please read the other replies (specifically mine) to
discover the real answer as to why modules can _legally_ have negative
use counts.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
