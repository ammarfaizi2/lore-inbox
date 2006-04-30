Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWD3Qx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWD3Qx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWD3QxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:53:25 -0400
Received: from zakalwe.fi ([80.83.5.154]:47880 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1751178AbWD3QxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:53:25 -0400
Date: Sun, 30 Apr 2006 16:53:23 +0000
From: Heikki Orsila <shd@zakalwe.fi>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: World writable tarballs
Message-ID: <20060430165323.GB19566@zakalwe.fi>
References: <1146356286.10953.7.camel@hammer> <200604300148.12462.s0348365@sms.ed.ac.uk> <20060430091501.GA19566@zakalwe.fi> <200604301249.16259.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200604301249.16259.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2006 at 12:49:16PM +0100, Alistair John Strachan wrote:
> Really, people that complain about security should have a modicum of a clue; 
> allowing a tar file that _somebody else_ applied _their_ security policy, to 
> define yours, is a deeply flawed concept. umask is there for a reason.

I think you are missing an important point here. Any person who compiles
a kernel image trusts the providers much more than file modes if one is
to run the kernel too so it's not like file modes are killer of trust
here. You might also argue that "NO_ROOT_HOLE=yes make modules_install"
is required for kernel to install non-world-writable modules.

My umask is just fine, 077. Also, as noted, it does make sense
that tar preserves attributes because admins use it for backuping.

-- 
Heikki Orsila                   Barbie's law:
heikki.orsila@iki.fi            "Math is hard, let's go shopping!"
http://www.iki.fi/shd
