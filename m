Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWE0WFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWE0WFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWE0WFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:05:46 -0400
Received: from gw.openss7.com ([142.179.199.224]:48297 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964988AbWE0WFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:05:45 -0400
Date: Sat, 27 May 2006 16:05:44 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060527160544.D15216@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060526093530.A20928@openss7.org> <0E42EDC8-3CC3-4161-8032-9599CA0ED63A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E42EDC8-3CC3-4161-8032-9599CA0ED63A@mac.com>; from mrmacman_g4@mac.com on Sat, May 27, 2006 at 10:41:28AM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle,

On Sat, 27 May 2006, Kyle Moffett wrote:

> On May 26, 2006, at 11:35:30, Brian F. G. Bidulock wrote:
> > On Fri, 26 May 2006, Arjan van de Ven wrote:
> >> /boot/config-`uname -r`
> >
> > Debian (Woody), OTOH strips extra names of their kernels, so 3 or 4  
> > different releases of the same upstream kernel version all install  
> > with the same name and report `uname -r` the same.  If multiple of  
> > these kernels and a vanilla kernel are installed, their config  
> > files will be difficult to distinguish.  dpkg can be used (similar  
> > to above for rpm) to test the condition.
> 
> Huh?  My Debian system here has:
> 
>    /boot/config-2.6.15-1-powerpc-smp
> 
> This corresponds to the config of the currently installed version and  
> revision ("2.6.15-8") of the "linux-image-2.6.15-1-powerpc-smp"  
> package.  Since you can only have one version of a given package  
> installed at once, this poses no problems.
> 
> If I upgrade to a new one (say "2.6.15-9") that changes the config  
> slightly or adds a new distro patch, then that config and kernel  
> image would replace the currently installed one.  If I use make-kpkg  
> to build and install a custom kernel tuned for "host":
> 
>    make-kpkg [args] --append-to-version -zeus1-1-powerpc-smp -- 
> revision 1 kernel_image
> 
> Now I get a package "linux-image-2.6.15-zeus1-1-powerpc-smp" version  
> "2.6.15-1", with:
> 
>    /boot/config-2.6.15-zeus1-1-powerpc-smp
> 
> I see no potential for confusion or mismatch here.

Woody, ... I said Woody, not Sarge.

2.4 kernel distributions under Woody had this problem.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
