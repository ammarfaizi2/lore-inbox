Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269460AbUIZAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269460AbUIZAom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUIZAom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:44:42 -0400
Received: from [69.25.196.29] ([69.25.196.29]:46775 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S269460AbUIZAol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:44:41 -0400
Date: Sat, 25 Sep 2004 20:41:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeremy Allison <jra@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040926004151.GC7278@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeremy Allison <jra@samba.org>, Linus Torvalds <torvalds@osdl.org>,
	YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
	samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925182907.GS580@jeremy1>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 11:29:07AM -0700, Jeremy Allison wrote:
> 
> Some history. I turn up at HP and look at the patch they
> have for this. They're putting the contents of st_blocks
> from the OS (HPUX in their case) into this field. I then
> write smbclient test code to test these extensions. Naturally
> (and as god intended :-), I assume 512 byte blocks in this
> value. When I look at the numbers they make no sense. 

HPUX... it *reminds* you of Unix....

						- Ted
