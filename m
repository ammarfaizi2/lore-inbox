Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRALWpY>; Fri, 12 Jan 2001 17:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135603AbRALWpO>; Fri, 12 Jan 2001 17:45:14 -0500
Received: from relay1.pair.com ([209.68.1.20]:32013 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S135548AbRALWpB>;
	Fri, 12 Jan 2001 17:45:01 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010112223949.4689.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: can't build small enough zImage for floppy
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Jordan's message of "Fri, 12 Jan 2001 15:48:23 -0600"
Organization: rows-n-columns
Date: 13 Jan 2001 09:39:49 +1100
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan <jordang@pcc.net> writes:

> 1st, the Sony Vaio Z505HS appears to be an example of a machine which
> will not boot a bzImage correctly, compaining about the compression
> format.

Maybe you need to upgrade to a newer version of lilo?

> 2nd, trying to build kernel 2.4.0, I stripped out or module-ized
> everything I could (I think) including SCSCI support, the smallest I've
> gotten zImage (under 600k) is still too big!

Don't use ``make zImage'', use ``make bzImage'' (big zImage) amd the
size will be fine.
-- 
Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
