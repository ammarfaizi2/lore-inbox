Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWHWVdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWHWVdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbWHWVdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:33:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:48834 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965216AbWHWVdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:33:51 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17644.51669.336558.548450@tut.ibm.com>
Date: Wed, 23 Aug 2006 16:34:13 -0500
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: zanussi@us.ibm.com, karim@opersys.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/3] kernel-doc for relay interface
In-Reply-To: <44BF9E42.60206@oracle.com>
References: <44BF9E42.60206@oracle.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap writes:
 > From: Randy Dunlap <rdunlap@xenotime.net>
 > 
 > Add relay interface support to DocBook/kernel-api.tmpl.
 > Fix typos etc. in relay.c and relayfs.txt.

Looks good, thanks.

I just posted new documentation for relayfs.txt that contains the
relayfs.txt fixes here (and moves it all to relay.txt), but the
kernel-api.tmpl and relay.c changes here should still be applied
(since relayfs.txt gets removed anyway, there shouldn't be any problem
applying this whole patch first)

Tom

Acked-by: Tom Zanussi <zanussi@us.ibm.com>

 > 
 > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
 > ---
 >  Documentation/DocBook/kernel-api.tmpl |   16 +++++++++++++++
 >  Documentation/filesystems/relayfs.txt |   30 ++++++++++++++--------------
 >  kernel/relay.c                        |   36 ++++++++++++++++++++--------------
 >  3 files changed, 53 insertions(+), 29 deletions(-)


