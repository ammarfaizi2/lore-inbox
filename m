Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUJUMKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUJUMKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUJUMA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:00:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38040 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268565AbUJTRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:21:24 -0400
Subject: Re: 2.6.9: io conflict between w83627hf_wdt and parport_pc
From: Lee Revell <rlrevell@joe-job.com>
To: Joerg Sommrey <jo175@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041020165408.GA5872@sommrey.de>
References: <20041020165408.GA5872@sommrey.de>
Content-Type: text/plain
Message-Id: <1098292880.1429.129.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 13:21:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 12:54, Joerg Sommrey wrote:
> /proc/ioports reports:
> |002e-0030 : winbond_check

Ugh.  Looks like this bug made it into 2.6.9:

http://lkml.org/lkml/2004/10/18/58

2.6.9.1?  :-)

Lee

