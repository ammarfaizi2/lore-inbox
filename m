Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUIYSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUIYSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUIYSb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:31:56 -0400
Received: from dp.samba.org ([66.70.73.150]:42390 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269381AbUIYSbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:31:55 -0400
Date: Sat, 25 Sep 2004 11:31:14 -0700
From: Jeremy Allison <jra@samba.org>
To: Jeremy Allison <jra@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925183114.GT580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925182907.GS580@jeremy1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 11:29:07AM -0700, Jeremy Allison wrote:

> So I decide, unilaterally (like you in the
> kernel I am god in the UNIX extensions space :-) to make this
> the number returned from st_blocks scaled as bytes.

We haven't re-published the UNIX extensions doc yet with
this fix (as a v2 or so) as we're still working on adding
things like POSIX ACLs and byte range locks (and maybe a
POSIX open) so my apologies on the current doc being out
of date.

Jeremy.
