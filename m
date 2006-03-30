Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWC3TQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWC3TQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWC3TQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:16:58 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:14893 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750762AbWC3TQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:16:57 -0500
Date: Thu, 30 Mar 2006 11:15:39 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Ian Kent <raven@themaw.net>,
       Joel Becker <joel.becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Urban Widmark <urban@teststation.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch 8/8] fs: use list_move()
Message-ID: <20060330191539.GP25194@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060330081605.085383000@localhost.localdomain> <20060330081731.538392000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081731.538392000@localhost.localdomain>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:16:13PM +0800, Akinobu Mita wrote:
> This patch converts the combination of list_del(A) and list_add(A, B)
> to list_move(A, B) under fs/.
Acked-by: Mark Fasheh <mark.fasheh@oracle.com>

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

