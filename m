Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUFBSV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUFBSV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUFBSV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:21:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:13466 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262065AbUFBSV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:21:28 -0400
Date: Wed, 2 Jun 2004 20:20:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602182019.GC30427@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 07:35:39 -0700, Davide Libenzi wrote:
> 
> Hmmm, I see more data to maintain to support a method that will never be 
> even close to be perfect.

You get it wrong.  This is mainly about Bad Code or Insufficient
Documentation.  In general, I want recursions to be removed, full
stop.  So there is not more data, but less.

If the recursion is actually wanted, then those cases should either be
so few and obvious that a single person can explain them all from
memory.  That, or things have to be written down somehow and unless
you have a better suggestion, any format is better than nothing.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
