Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbVLQS0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVLQS0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVLQS0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:26:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53431 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932649AbVLQS0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:26:19 -0500
Subject: Re: remove CONFIG_UID16
From: Lee Revell <rlrevell@joe-job.com>
To: 7eggert@gmx.de
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E1EnZIZ-0003Px-3c@be1.lrz>
References: <5kCbe-45z-7@gated-at.bofh.it>  <E1EnZIZ-0003Px-3c@be1.lrz>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:29:27 -0500
Message-Id: <1134844168.11227.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 11:28 +0100, Bodo Eggert wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > It seems noone noticed that CONFIG_UID16 was accidentially always
> > disabled in the latest -mm kernels.
> > 
> > Is there any reason against removing it completely?
> 
> Maybe embedded systems.

The comments in the code say it's for backwards compatibility:

(from include/linux/highuid.h)

 *
 * CONFIG_UID16 is defined if the given architecture needs to
 * support backwards compatibility for old system calls.
 *

This implies that removing it would break some applications, right?

Lee

