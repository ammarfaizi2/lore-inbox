Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFLU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFLU0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFLU0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:26:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20920 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750703AbWFLU0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:26:20 -0400
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
	error -28
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <448DC93E.9050200@rtr.ca>
References: <448DC93E.9050200@rtr.ca>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:26:08 -0400
Message-Id: <1150143968.3062.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 16:06 -0400, Mark Lord wrote:
> Greg,
> 
> With 2.6.17-rc6-git2, I'm seeing this kernel message during start-up:
> 
>   pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28

Do you have USB bandwidth checking enabled?  It's known to be broken.

Lee

