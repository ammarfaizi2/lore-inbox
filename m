Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVAVOYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVAVOYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 09:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVAVOYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 09:24:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262724AbVAVOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 09:24:14 -0500
Date: Sat, 22 Jan 2005 15:23:53 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>, cpufreq@zenII.linux.org.uk,
       "H. Peter Anvin" <hpa@zytor.com>, Dominik Brodowski <linux@brodo.de>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH]: speedstep-lib: fix frequency multiplier for Pentium4 models 0&1
Message-ID: <20050122142353.GB19194@devserv.devel.redhat.com>
References: <41F259C4.9020903@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F259C4.9020903@tiscali.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jan 22, 2005 at 02:48:52PM +0100, Matthias-Christian Ott wrote:
> The Pentium4 models 0&1 have a longer MSR_EBC_FREQUENCY_ID register as 
> the models 2&3, so the bit shift must be bigger.

I would feel safer if this checked that it was actually a p4 as well...
