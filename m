Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbTC0RCI>; Thu, 27 Mar 2003 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbTC0RCH>; Thu, 27 Mar 2003 12:02:07 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:34030 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263299AbTC0RBf>; Thu, 27 Mar 2003 12:01:35 -0500
Date: Thu, 27 Mar 2003 09:10:58 -0800
From: Chris Wright <chris@wirex.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030327091058.A22868@figure1.int.wirex.com>
Mail-Followup-To: Jan Kasprzak <kas@informatics.muni.cz>,
	Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
	mc@cs.stanford.edu
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321155547.C646@figure1.int.wirex.com> <20030327090713.A19647@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030327090713.A19647@fi.muni.cz>; from kas@informatics.muni.cz on Thu, Mar 27, 2003 at 09:07:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kasprzak (kas@informatics.muni.cz) wrote:
> Chris Wright wrote:
> : Both cosa_readmem and cosa_download don't seem to do any validation of
> : the user supplied ptr at all before dereferncing it in get_user.  And
> : it'd make sense to use 'code' in cosa_reamdme (as in cosa_download)
> : instead of 'd->code'.  Jan, does this look OK?
> 
> 	Yes, you are right. I've missed this. However, it is not
> as bad as it looks like, because you need the CAP_SYS_RAWIO to
> exploit this. I agree this patch should be applied.

Thanks for the confirmation.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
