Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbULUCGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbULUCGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbULUCGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:06:50 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37056 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261183AbULUCGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:06:49 -0500
Subject: Re: ioctl assignment strategy?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1103589129.32548.10.camel@localhost.localdomain>
References: <1103067067.2826.92.camel@chatsworth.hootons.org>
	 <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com>
	 <20041217234854.GA24506@kroah.com> <41C70DF2.80101@nortelnetworks.com>
	 <41C756CA.5080504@xs4all.nl>
	 <1103589129.32548.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 21:06:48 -0500
Message-Id: <1103594808.8297.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 00:32 +0000, Alan Cox wrote:
> The "ioctls are evil" blind hate department really annoy me however
> because like all extreme views the truth very rarely fits their model

Another objection was that all ioctls take the BKL.  I think you did not
hear this one raised as much because it reflected a deficiency in the
system.  But now at least 2 different solutions have been posted for
BKL-less ioctls so that objection is no longer valid.

Lee

