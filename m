Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWC3TJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWC3TJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWC3TJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:09:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:38886 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750751AbWC3TJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:09:06 -0500
Date: Thu, 30 Mar 2006 11:07:40 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Ian Kent <raven@themaw.net>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Urban Widmark <urban@teststation.com>,
       David Howells <dhowells@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [patch 8/8] fs: use list_move()
Message-ID: <20060330190740.GB29730@ca-server1.us.oracle.com>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Ian Kent <raven@themaw.net>, Neil Brown <neilb@cse.unsw.edu.au>,
	Hans Reiser <reiserfs-dev@namesys.com>,
	Urban Widmark <urban@teststation.com>,
	David Howells <dhowells@redhat.com>,
	Mark Fasheh <mark.fasheh@oracle.com>
References: <20060330081605.085383000@localhost.localdomain> <20060330081731.538392000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081731.538392000@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:16:13PM +0800, Akinobu Mita wrote:
> This patch converts the combination of list_del(A) and list_add(A, B)
> to list_move(A, B) under fs/.
> 
> CC: Ian Kent <raven@themaw.net>
> CC: Joel Becker <joel.becker@oracle.com>
> CC: Neil Brown <neilb@cse.unsw.edu.au>
> CC: Hans Reiser <reiserfs-dev@namesys.com>
> CC: Urban Widmark <urban@teststation.com>
> CC: David Howells <dhowells@redhat.com>
> CC: Mark Fasheh <mark.fasheh@oracle.com>
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Acked-by: Joel Becker <joel.becker@oracle.com>

-- 

"And yet I find,
 And yet I find repeating in my head.
 If I can't be my own, 
 I'd feel better dead."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
