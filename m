Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUIYSdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUIYSdp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUIYSdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:33:45 -0400
Received: from dp.samba.org ([66.70.73.150]:44182 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269377AbUIYSde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:33:34 -0400
Date: Sat, 25 Sep 2004 11:32:51 -0700
From: Jeremy Allison <jra@samba.org>
To: Jeremy Allison <jra@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925183251.GU580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org> <20040925182021.GR580@jeremy1> <20040925182506.GA2971@bouh.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925182506.GA2971@bouh.is-a-geek.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 08:25:06PM +0200, Samuel Thibault wrote:
> 
> That's what I submitted, but:
> 
> > Happy ?
> 
> No, because there's still the minimum of 1MB... What have Microsoft
> things to do with unix CIFS extensions ?...

Well in this case it's because they're using the same underlying
logic in the call. I'll fix this for Samba 3.0.8 or 9 - hand out
on samba-technical if you want the patch before then.

Ok, it's a bug. So kill me :-). Happy *now* ? :-).

Jeremy.
