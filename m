Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131739AbQLGSsR>; Thu, 7 Dec 2000 13:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLGSsH>; Thu, 7 Dec 2000 13:48:07 -0500
Received: from icarus.com ([208.36.26.146]:53764 "EHLO icarus.com")
	by vger.kernel.org with ESMTP id <S131685AbQLGSrz>;
	Thu, 7 Dec 2000 13:47:55 -0500
Message-Id: <200012071817.KAA08227@icarus.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Mike Dresser <mdresser@windsormachine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 40Gig IDE disk wrapping around at 32Gig? 
In-Reply-To: Your message of "Thu, 07 Dec 2000 13:02:53 EST."
             <3A2FD0CD.3B9FF8B6@windsormachine.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Dec 2000 10:17:19 -0800
From: Stephen Williams <steve@icarus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mdresser@windsormachine.com said:
> My understanding is that the part you're accessing, above 33.6 gig,
> wraps around the int or whatever they use(i'm not a programmer, and
> i'm not going to think about what it'd actually be <grin>)

2.2.17 solves the problem. The 2.2.12 kernel definitely goes
berserk when faced with blocks way up there. With 2.2.17, the whole
disk works fine.

Thanks for the fast response.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve@icarus.com              But I have promises to keep,
steve@picturel.com            and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
