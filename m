Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUDBVro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUDBVro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:47:44 -0500
Received: from [144.51.25.10] ([144.51.25.10]:4274 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261162AbUDBVri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:47:38 -0500
Subject: Re: capabilitiescompute_cred
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       luto@myrealbox.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <406DCB32.8070403@stanford.edu>
References: <20040402033231.05c0c337.akpm@osdl.org>
	 <1080912069.27706.42.camel@moss-spartans.epoch.ncsc.mil>
	 <20040402111554.E21045@build.pdx.osdl.net>  <406DCB32.8070403@stanford.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1080942432.28777.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Apr 2004 16:47:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 15:21, Andy Lutomirski wrote:
> I agree in principle, but it would still be nice to have a simple way to 
> have useful capabilities without setting up a MAC system.  I don't see a 
> capabilities fix adding any significant amount of code; it just takes 
> some effort to get it right.

I'm not opposed to making the existing capability logic more useable; I
just think that capabilities will ultimately be superseded by TE.
 
> You can find my attempts to get it right in the 
> linux-kernel archives, and I'll probably try to get something into 2.7 
> when it forks.  With or without MAC, having a functioning capability 
> system wouldn't hurt security.

Does revising the capability logic need to wait on 2.7?  Have you
changed the logic significantly since the last patch you posted to lkml?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

