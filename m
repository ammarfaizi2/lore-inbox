Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVCFUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVCFUGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCFUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:06:40 -0500
Received: from isilmar.linta.de ([213.239.214.66]:47541 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261485AbVCFUGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:06:37 -0500
Date: Sun, 6 Mar 2005 21:06:36 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unsupported PM cap regs version 1
Message-ID: <20050306200636.GA5340@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1110053135.12513.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110053135.12513.7.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 03:05:35PM -0500, Lee Revell wrote:
> Every time I load the driver for my SBLive Platinum I get this log
> message:
> 
> PCI: 0000:00:0f.0 has unsupported PM cap regs version (1)

PM cap regs version 1 is handled in 2.6.11 yet again, the message should be
gone for this case by now.

> even though CONFIG_PM is not set.

PM caps are needed to activate devices, even if CONFIG_PM is not set.

	Dominik
