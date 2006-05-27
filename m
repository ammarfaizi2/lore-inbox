Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWE0UVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWE0UVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWE0UVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:21:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964965AbWE0UVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:21:44 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: bidulock@openss7.org
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060527135214.A15216@openss7.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060526093530.A20928@openss7.org>
	 <1148732512.3265.0.camel@laptopd505.fenrus.org>
	 <20060527135214.A15216@openss7.org>
Content-Type: text/plain
Date: Sat, 27 May 2006 22:21:39 +0200
Message-Id: <1148761299.3265.241.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-27 at 13:52 -0600, Brian F. G. Bidulock wrote:
> Arjan,
> 
> On Sat, 27 May 2006, Arjan van de Ven wrote:
> 
> > 
> > > > 
> > > 
> > > Redhat and SuSE put /boot/config- files of the same name for different
> > > architectures (i386, i586) in the same file.  If multiple architecture
> > > kernels of the same verion are installed, there is no guarantee that the
> > > /boot/config-`uname -r` is not for, say, i686 instead of i386.  
> > 
> > at least on fedora you can't do that parallel installation anyway
> 
> rpm --force

at which point 95% of the files get overwritten including the config
file, which then points to the right place of the 2nd kernel you abuse
onto your system.

