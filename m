Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUEXXuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUEXXuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEXXuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:50:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:11650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264288AbUEXXuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:50:01 -0400
Date: Mon, 24 May 2004 16:49:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Cc: Steve Youngs <steve@youngs.au.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Modifying kernel so that non-root users have some root capabilities
Message-ID: <20040524164956.P22989@build.pdx.osdl.net>
References: <67B3A7DA6591BE439001F2736233351202B47E87@xch-nw-28.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E87@xch-nw-28.nw.nos.boeing.com>; from Joseph.V.Laughlin@boeing.com on Mon, May 24, 2004 at 04:41:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Laughlin, Joseph V (Joseph.V.Laughlin@boeing.com) wrote:
> > From: Steve Youngs [mailto:steve@youngs.au.com] 
> > 
> > I'm assuming that there are user-land tools to do these 
> > things now for root, right?  So why not look into things like 
> > sudo(8) or even setuid executables? 
> 
> In short, it comes down to permissions problems with NFS mounted
> directories, combined with Rational ClearCase issues, combined with
> stringent security requirements.

Uh-oh, sounds like an insurmountable problem ;-) Well, keep in mind that
CAP_SYS_NICE and CAP_IPC_LOCK can DoS a machine pretty nicely.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
