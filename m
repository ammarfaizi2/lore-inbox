Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWEaAkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWEaAkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWEaAkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:40:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751506AbWEaAks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:40:48 -0400
Date: Tue, 30 May 2006 20:40:40 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Sandall <eric@sandall.us>
Cc: linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Subject: Re: cpufreq and kernel >2.6.15.6 is limited
Message-ID: <20060531004040.GI13966@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Sandall <eric@sandall.us>, linux-kernel@vger.kernel.org,
	Mattia Dongili <malattia@linux.it>
References: <447CE276.5080808@sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447CE276.5080808@sandall.us>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 05:25:26PM -0700, Eric Sandall wrote:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > It seems that any kernel on my Dell Inspiron 5100 after 2.6.15.6
 > (including 2.6.17-rc5) 'breaks' my cpufreq in that up to and including
 > 2.6.15.6 I can scale between 300MHz-2.4GHz, but after (starting with
 > 2.6.16) I can only scale between 2.1GHz and 2.4GHz.
 > 
 > I've attached the files, sorted by kernel, I assume may be helpful. Let
 > me know if you need any more.

It may have worked in the past, but the CPU has an errata which makes
it an unsafe operation to scale below 2GHz.

		Dave

-- 
http://www.codemonkey.org.uk
