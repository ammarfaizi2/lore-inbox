Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWE0WVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWE0WVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWE0WVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:21:21 -0400
Received: from gw.openss7.com ([142.179.199.224]:59305 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S965007AbWE0WVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:21:21 -0400
Date: Sat, 27 May 2006 16:21:18 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060527162118.E15216@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060526093530.A20928@openss7.org> <1148732512.3265.0.camel@laptopd505.fenrus.org> <20060527135214.A15216@openss7.org> <1148761299.3265.241.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1148761299.3265.241.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Sat, May 27, 2006 at 10:21:39PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Sat, 27 May 2006, Arjan van de Ven wrote:

> On Sat, 2006-05-27 at 13:52 -0600, Brian F. G. Bidulock wrote:
> > Arjan,
> > 
> > On Sat, 27 May 2006, Arjan van de Ven wrote:
> > 
> > > 
> > > > > 
> > > > 
> > > > Redhat and SuSE put /boot/config- files of the same name for different
> > > > architectures (i386, i586) in the same file.  If multiple architecture
> > > > kernels of the same verion are installed, there is no guarantee that the
> > > > /boot/config-`uname -r` is not for, say, i686 instead of i386.  
> > > 
> > > at least on fedora you can't do that parallel installation anyway
> > 
> > rpm --force
> 
> at which point 95% of the files get overwritten including the config
> file, which then points to the right place of the 2nd kernel you abuse
> onto your system.

But not the right place for the running kernel.  /boot/config-`uname -r` will
be of the wrong architecture for the running kernel.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
