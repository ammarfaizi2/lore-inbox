Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266192AbUGKK7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUGKK7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUGKK7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:59:47 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:9105 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266192AbUGKK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:59:46 -0400
Date: Sun, 11 Jul 2004 11:57:00 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cpufreq.c: reorder for inlining
Message-ID: <20040711105700.GB9714@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040711104012.GB4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711104012.GB4701@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 12:40:13PM +0200, Adrian Bunk wrote:
 
 > The patc below reorders cpufreq.c to move adjust_jiffies before it's 
 > callers.
 > 
 > diffstat output:
 >  drivers/cpufreq/cpufreq.c |  160 +++++++++++++++++++-------------------
 >  1 files changed, 80 insertions(+), 80 deletions(-)
 > 
 > 
 > Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

Applied, Thanks Adrian.

		Dave

