Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUCDTwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUCDTwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:52:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262101AbUCDTwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:52:04 -0500
Date: Thu, 4 Mar 2004 14:51:55 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Arthur Corliss <corliss@digitalmages.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.58.0403040901010.30814@bifrost.nevaeh-linux.org>
Message-ID: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0403041451362.20043@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Arthur Corliss wrote:

> The patch only changes two lines which redefine the ac_uid/ac_gid fields as
> uid_t/gid_t respectively.  Fixes accounting for high uid/gids.

Do the userspace commands that parse the acct files
know how to deal with this format change ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

