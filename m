Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131491AbRCWWdR>; Fri, 23 Mar 2001 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCWWcJ>; Fri, 23 Mar 2001 17:32:09 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:63505 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S131480AbRCWWbQ>; Fri, 23 Mar 2001 17:31:16 -0500
Date: Fri, 23 Mar 2001 16:29:56 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010323162956.A27066@ganymede.isdn.uiuc.edu>
In-Reply-To: <20010323011140.A1176@werewolf.able.es> <E14gFRT-0003f4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14gFRT-0003f4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 23, 2001 at 12:28:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Alan Cox:

} > -	default:
} > +	default:;
} 
} Agree - done
} 
This kind of coding makes me want to cry. What's so wrong with:

	default:
		break;
	
instead? The ';' is hard to notice and, if people don't leave the
"default:" at the end, then bad things could happen...

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
