Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWBMBSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWBMBSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWBMBSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:18:36 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24547 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751540AbWBMBSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:18:35 -0500
Subject: Re: [PATCH 09/13] hrtimer: remove data field
From: Lee Revell <rlrevell@joe-job.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602130211150.23843@scrub.home>
References: <Pine.LNX.4.61.0602130211150.23843@scrub.home>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 20:18:32 -0500
Message-Id: <1139793512.2739.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 02:11 +0100, Roman Zippel wrote:
> Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
> time it returned useful data (as it was directly maintained by the
> scheduler), now it's only a waste of time to calculate it.

Won't this break apps that parse this file?

Lee

