Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVEJPan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVEJPan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVEJPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:30:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1666 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261686AbVEJP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:29:56 -0400
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Lammerts <eric@lammerts.org>
Cc: Markus Klotzbuecher <mk@creamnet.de>, linux-kernel@vger.kernel.org
In-Reply-To: <42804FA9.3020307@lammerts.org>
References: <20050509183135.GB27743@mary>  <42804FA9.3020307@lammerts.org>
Content-Type: text/plain
Date: Tue, 10 May 2005 11:29:52 -0400
Message-Id: <1115738992.12402.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 02:07 -0400, Eric Lammerts wrote:
> Markus Klotzbuecher wrote:
> > mini_fo is a virtual kernel filesystem that can make read-only file
> > systems writable.
> 
> Nice.
> 
> Some remarks:
> Some functions return -ENOTSUPP on error, which makes "ls -l" complain 
> loudly when getxattr() fails. This should be -EOPNOTSUPP.
> 
> The module taints the kernel because of MODULE_LICENSE("LGPL").
> Since all your copyright statements say it's GPL software, better change 
> this to "GPL".

Ugh.  Why does an LGPL module taint the kernel again?

Lee

