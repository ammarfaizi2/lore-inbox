Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVESPUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVESPUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVESPUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:20:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32428 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262551AbVESPUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:20:10 -0400
Subject: Re: [RFC] [PATCH] OCFS2
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Phillips <phillips@istop.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
In-Reply-To: <428C69EA.6080001@pobox.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
	 <200505190230.23624.phillips@istop.com>  <428C69EA.6080001@pobox.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 11:20:08 -0400
Message-Id: <1116516008.21685.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 06:26 -0400, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > Zero terminated strings for lock names is bad taste.  It generates a bunch of 
> > useless strlen executions and you force an ascii namespace for no apparent 
> > reason.  Add a 9th parameter, namelen, to the lock call maybe?
> 
> What's wrong with ascii strings?
> 
> We call those 'UTF8' these days.

I think you just answered your own question.

Lee

