Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUIYTQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUIYTQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUIYTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:16:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:28864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269392AbUIYTQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:16:36 -0400
Date: Sat, 25 Sep 2004 12:16:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925182021.GR580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251216000.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
 <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
 <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org> <20040925182021.GR580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
> 
> To recap, if we have st_blocks from the filesystem we use it
> and send the value scaled as bytes, if not we send the actual
> file size there in bytes (as we know any POSIX system has at
> least that).
> 
> Happy ?

Not really. Where did that 1MB minimum value come from?

		Linus
