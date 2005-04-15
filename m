Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVDOSKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVDOSKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVDOSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:10:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38341 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261885AbVDOSIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:08:16 -0400
Subject: Re: Kernel Rootkits
From: Lee Revell <rlrevell@joe-job.com>
To: "Malita, Florin" <Florin.Malita@Glenayre.com>
Cc: linux-os@analogic.com, Allison <fireflyblue@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1113586421.26941.121.camel@scox.glenatl.glenayre.com>
References: <1113586421.26941.121.camel@scox.glenatl.glenayre.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 14:08:14 -0400
Message-Id: <1113588494.23659.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 13:33 -0400, Malita, Florin wrote:
> On Fri, 2005-04-15 at 13:16 -0400, Richard B. Johnson wrote:
> > I'm not sure there really are any "kernel" rootkits. You need to be 
> > root to install a module and you need to be root to replace a kernel 
> > with a new (possibly altered) one. If you are root, you don't 
> > need an exploit.
> 
> rootkit != exploit
> 
> The exploit is used to gain root privileges while the rootkit is used
> after that to install & hide backdoors, sniffers, keyloggers etc.
> 
> http://en.wikipedia.org/wiki/Rootkit
> 

"Rootkit" is sometimes used to refer to the all-in-one bundle, that
contains the exploit and the tools the attacker installs once they are
in.

OT: the dumbest rootkit I ever came across came from someone who cracked
one of our nameservers via an openssh hole.  They were careful to
replace netstat, ps, etc but apparently didn't know about lsof, which
was the first thing I tried of course.  Then they hid the old binaries
in a subdirectory of /dev (because no one would ever look there).
Thanks to the "l33t skillz" of the author, I didn't even have to wipe
the machine to recover it.

Lee

