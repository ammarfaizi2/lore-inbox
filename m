Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWAPIHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWAPIHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAPIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:07:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24541 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932221AbWAPIHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:07:37 -0500
Subject: Re: 2.6.15 on powerbook 15" still oopsing on resume with cd/dvd in
	drive
From: Lee Revell <rlrevell@joe-job.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
In-Reply-To: <1137318398.24666.25.camel@localhost>
References: <1137318398.24666.25.camel@localhost>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 03:07:34 -0500
Message-Id: <1137398855.19444.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-15 at 10:46 +0100, Soeren Sonnenburg wrote:
> BUG: soft lockup detected on CPU#0!

Not an oops but a soft lockup.  It means some piece of code ran in the
kernel for a very long time.

This seems like a false positive to me, as it involves IDE.

Lee

