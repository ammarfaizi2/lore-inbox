Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUBSSeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUBSSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:34:36 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:56961 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267475AbUBSSeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:34:20 -0500
Date: Thu, 19 Feb 2004 19:34:16 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Kieran <kieran@ihateaol.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_pid_stat crashes in 2.6.2 (was 2.6.0-test11: Crash in ps axH)
Message-ID: <20040219183416.GA12962@vana.vc.cvut.cz>
References: <20040219182329.GA10868@vana.vc.cvut.cz> <403500DA.3060906@ihateaol.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403500DA.3060906@ihateaol.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 06:30:50PM +0000, Kieran wrote:
> >Hi,
> >  I already reported this crash twice on 2.6.0-test11, and now I
> >reproduced it on something more fresh - on 2.6.2-bk-something like it
> >was actual on Feb 4. It is really annoying, as any user can do 'ps axH'
> >and crash system after some uptime :-( Crash is identical to one
> >I got with 2.6.0-test11, so it looks like that I'll have to go back
> >to 2.4.x on publicly accessible machines. After about 14 days uptime. 
> >
> >  I've got no replies to previous reports.
> >  						Thanks,
> >							Petr Vandrovec
> >							vandrove@vc.cvut.cz
> 
> what version of procps?

Not that it should matter, as walking through /proc/* could do same,
but... 3.1.15-3. I have no idea what procps were installed at the
beginning of February or in the December. Until crash 'ps ax' does not
cause problem. Only 'axH', which descends to /task/ subdirectories,
crashes.

usermap:~# dpkg -l procps
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name                       Version                    Description
+++-==========================-==========================-====================================================================
ii  procps                     3.1.15-3                   The /proc file system utilities
usermap:~#

							Petr Vandrovec

