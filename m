Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbTCOUnW>; Sat, 15 Mar 2003 15:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbTCOUnW>; Sat, 15 Mar 2003 15:43:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21720 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261539AbTCOUnV>; Sat, 15 Mar 2003 15:43:21 -0500
Date: Sat, 15 Mar 2003 12:53:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pavel Machek <pavel@ucw.cz>, Daniel Phillips <phillips@arcor.de>
cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <36800000.1047761634@[10.10.2.4]>
In-Reply-To: <20030314122903.GC8057@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030314122903.GC8057@zaurus.ucw.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes.
> 
> Some kind of better-patch is badly needed.
> 
> What kind of data would have to be in soft-changeset?
> * unique id of changeset
> * unique id of previous changeset
> (two previous if it is merge)
> ? or would it be better to have here
> whole path to first change?
> * commit comment
> * for each file:
> ** diff -u of change
> ** file's unique id
> ** in case of rename: new name (delete is rename to special dir)
> ** in case of chmod/chown: new permissions
> ** per-file comment
> 
> ? How to handle directory moves?
> 
> Does it seem sane? Any comments?

Looks good to me. 

If people keep changesets sanely, then there should be no need for 
per-file comments IMHO, but I'm sure that's a matter of debate.

M.

