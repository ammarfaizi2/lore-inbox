Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTHJXYD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTHJXYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:24:03 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31634 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270763AbTHJXYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:24:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Mon, 11 Aug 2003 09:23:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16182.54248.868067.968522@gargle.gargle.HOWL>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: message from Stephan von Krawczynski on Sunday August 10
References: <20030808170536.23118033.skraw@ithnet.com>
	<Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
	<20030810233526.0f7bf65b.skraw@ithnet.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 10, skraw@ithnet.com wrote:
> 
> From looking at the tests so far I would say the setup is remarkably slower in
> terms of writing to ext3 via nfs and sync option set. I think especially the
> "sync" is very visible - unlike reiserfs.

  data=journal
makes nfsd go noticable faster over ext3.  Having an external journal
is even better.

NeilBrown
