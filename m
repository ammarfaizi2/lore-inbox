Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbUKQCMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUKQCMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbUKQCLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:11:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31934 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262162AbUKQCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:00:49 -0500
Subject: Re: 2.6.10-rc2-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Jack O'Quin" <joq@io.com>
In-Reply-To: <20041116014213.2128aca9.akpm@osdl.org>
References: <20041116014213.2128aca9.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 16:38:11 -0500
Message-Id: <1100641092.16765.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 01:42 -0800, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.10-rc2-mm1.gz
> 

I would like to request that the realtime LSM be included in the next
-mm release.

Here is the current patch:

http://lkml.org/lkml/diff/2004/11/9/288/1

Here is Jack's announcement:

http://lkml.org/lkml/2004/11/9/288

No objections were raised to the patch in its current form.

This applies cleanly against 2.6.10-rc2-mm1.  The short version of what
it does is "enables selected non-root users to run RT apps (ie use
SCHED_FIFO and mlock)".

Lee

