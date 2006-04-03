Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWDCBHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDCBHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 21:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWDCBHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 21:07:24 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:57864 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S964800AbWDCBHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 21:07:23 -0400
Date: Mon, 3 Apr 2006 09:04:54 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Urban Widmark <urban@teststation.com>,
       David Howells <dhowells@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [patch 8/8] fs: use list_move()
In-Reply-To: <20060330190740.GB29730@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.64.0604030904370.2348@eagle.themaw.net>
References: <20060330081605.085383000@localhost.localdomain>
 <20060330081731.538392000@localhost.localdomain> <20060330190740.GB29730@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Joel Becker wrote:

> On Thu, Mar 30, 2006 at 04:16:13PM +0800, Akinobu Mita wrote:
> > This patch converts the combination of list_del(A) and list_add(A, B)
> > to list_move(A, B) under fs/.
> > 
> > CC: Ian Kent <raven@themaw.net>
> > CC: Joel Becker <joel.becker@oracle.com>
> > CC: Neil Brown <neilb@cse.unsw.edu.au>
> > CC: Hans Reiser <reiserfs-dev@namesys.com>
> > CC: Urban Widmark <urban@teststation.com>
> > CC: David Howells <dhowells@redhat.com>
> > CC: Mark Fasheh <mark.fasheh@oracle.com>
> > Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> Acked-by: Joel Becker <joel.becker@oracle.com>
> 
> -- 
> 
> "And yet I find,
>  And yet I find repeating in my head.
>  If I can't be my own, 
>  I'd feel better dead."

ACK


