Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbRDMKj7>; Fri, 13 Apr 2001 06:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135464AbRDMKjt>; Fri, 13 Apr 2001 06:39:49 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:45328 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135463AbRDMKjp>;
	Fri, 13 Apr 2001 06:39:45 -0400
Date: Fri, 13 Apr 2001 12:39:39 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2.4.4 -pre2)
Message-ID: <20010413123939.B30971@pcep-jamie.cern.ch>
In-Reply-To: <86256A2C.0068BA0C.00@smtpnotes.altec.com> <200104121931.VAA02438@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104121931.VAA02438@ns.caldera.de>; from hch@ns.caldera.de on Thu, Apr 12, 2001 at 09:31:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> So the /* old gcc */ part should probably be enabled based on a define for the
> old compiler.  The right ifdef seems to be:
> 
>   #if __GNUC__ == 2 && __GNUC_MINOR__ < 95

The current GCC supports the old syntax and will do so for a while yet,
so perhaps this is not required?

-- Jamie
