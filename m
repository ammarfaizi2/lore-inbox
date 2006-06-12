Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWFLViv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWFLViv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFLViv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:38:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49084 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932386AbWFLViv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:38:51 -0400
Subject: Re: [PATCH] Fix for the PPTP hangs that have been reported
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, xxebxebx@gmail.com
In-Reply-To: <17548.52858.22555.610055@cargo.ozlabs.ibm.com>
References: <17548.52858.22555.610055@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 17:38:47 -0400
Message-Id: <1150148328.3062.49.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 12:16 +1000, Paul Mackerras wrote:
> People have been reporting that PPP connections over ptys, such as
> used with PPTP, will hang randomly when transferring large amounts of
> data, for instance in http://bugzilla.kernel.org/show_bug.cgi?id=6530.
> I have managed to reproduce the problem, and the patch below fixes the
> actual cause.

I was terribly afflicted by this bug and the patch seems to help.

Strangely, it made PPTP completely unusable with the -rt kernel - the
connection would hang forever - but with 2.6.16 it only seemed to slow
things down.

Lee

