Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbTC0QUV>; Thu, 27 Mar 2003 11:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbTC0QUV>; Thu, 27 Mar 2003 11:20:21 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:9433 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263294AbTC0QUT>; Thu, 27 Mar 2003 11:20:19 -0500
Date: Thu, 27 Mar 2003 16:31:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030327163111.GA27455@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com> <20030324182508.A15039@vger.timpanogas.org> <20030327160220.GA29195@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327160220.GA29195@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 08:02:20AM -0800, Larry McVoy wrote:

 > Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
 > slovax kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 > 
 > Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
 > slovax kernel: Bank 1: 9000000000000151

An MCE (Machine Check Exception) could be triggered by any number of
things from bad cooling, underrated power supply, to flaky RAM.
Give things a going over with memtest86 for the latter.
The former just means you pull everything apart and double check
it looks ok.

		Dave

