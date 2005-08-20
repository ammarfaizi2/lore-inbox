Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbVHTTBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbVHTTBb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbVHTTBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:01:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32414 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932782AbVHTTBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:01:31 -0400
Subject: Re: [patch 2.6.13-rc6] i386: semaphore ownership tracking
From: Lee Revell <rlrevell@joe-job.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, ak@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200508200310_MC3-1-A7BC-D1C0@compuserve.com>
References: <200508200310_MC3-1-A7BC-D1C0@compuserve.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 15:01:27 -0400
Message-Id: <1124564488.26949.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 03:07 -0400, Chuck Ebbert wrote:
> On Fri, 19 Aug 2005 at 20:02:27 -0700, Andrew Morton wrote:
> 
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > >  This patch enables tracking semaphore ownership.
> > 
> > Why?  I can't think of any bug in recent years which needed this..
> 
>  It might be useful in new driver development.  OTOH it is really ugly
> even if it's a small patch.

How is it different from the ownership tracking used for PI in the -rt
kernel?

Lee

