Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVCJRlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVCJRlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVCJRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:36:18 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56273 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262838AbVCJRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:25:18 -0500
Subject: Re: 2.6.11-mm2 + Radeon crash
From: Lee Revell <rlrevell@joe-job.com>
To: Christian Henz <christian.henz@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <493984f050309121212541d8@mail.gmail.com>
References: <493984f050309121212541d8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 12:25:15 -0500
Message-Id: <1110475516.12805.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 21:12 +0100, Christian Henz wrote:
> Hi, 
> 
> I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
> I've run into a severe
> problem.

There is absolutely no reason to use the -mm kernel anymore for low
latency audio.  The -mm kernels were never stable enough to work well
for audio users anyway.

The latest version of Ingo's realtime preempt patch is against
2.6.11-rc4.  Supposedly it applies and works with 2.6.11 vanilla, you
just have to edit the patch not to expect -rc4 as the EXTRAVERSION.

Lee

