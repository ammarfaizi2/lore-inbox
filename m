Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271074AbRHTFDX>; Mon, 20 Aug 2001 01:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271079AbRHTFDN>; Mon, 20 Aug 2001 01:03:13 -0400
Received: from [65.10.228.207] ([65.10.228.207]:19698 "HELO whatever.local")
	by vger.kernel.org with SMTP id <S271074AbRHTFDB>;
	Mon, 20 Aug 2001 01:03:01 -0400
From: chuckw@ieee.org
Date: Sun, 19 Aug 2001 13:11:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Question on coding style in networking code
Message-ID: <20010819131131.I2388@ieee.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010819124442.G2388@ieee.org> <Pine.GSO.4.21.0108200046580.1313-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0108200046580.1313-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Aug 20, 2001 at 12:56:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Thank you for the reply.

	I absolutely agree that it is much easier to read and figure out what is
going on.  You don't have to keep going back to the struct declaration to
find out what the fields are.  

Thanks again,
Chuck

On Mon, Aug 20, 2001 at 12:56:53AM -0400, Alexander Viro wrote:
> 
> 
> On Sun, 19 Aug 2001 chuckw@ieee.org wrote:
> 
> > 	struct x y = {
> > 		member1: x,
> > 		member2: y,
> > 		member3: z
> > 	};
> > 
> > What is the deal with this?  Does the second way have any advantage over the previous?
> 
> _Much_ easier to grep for. Less pain in the ass when fields are added/removed/
> reordered.
> 
> For anything with many fields (usually method tables) it's more convenient.
> And no, it's not just networking - filesystem-related code, etc. uses it
> all over the place.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
