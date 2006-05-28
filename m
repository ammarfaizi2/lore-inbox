Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWE1Qxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWE1Qxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWE1Qxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:53:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47574 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750790AbWE1Qxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:53:47 -0400
Date: Sun, 28 May 2006 12:53:38 -0400
From: Dave Jones <davej@redhat.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] 2.6.17rc emu10k1 regression.
Message-ID: <20060528165338.GA4692@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	James Courtier-Dutton <James@superbug.co.uk>,
	alsa-devel@alsa-project.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060528164015.GA13499@redhat.com> <4479D500.2060305@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4479D500.2060305@superbug.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 05:51:12PM +0100, James Courtier-Dutton wrote:

 > > cannot find the slot for index 0 (range 0-1)
 > > EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12
 > > 
 > > (Unremarkable, considering it *isn't* an Audigy)
 > The same driver is used for the EMU10K1 and the Prodigy.
 > the -12 is an "Out of memory", so something outside the alas driver tree
 > must have changed to cause this problem.

I rebooted into exactly the same kernel, and everything magically
started working again. Puzzling.  There were no other signs of memory
exhaustion.

Hmm. Will keep an eye on things to see if it happens again.

		Dave

-- 
http://www.codemonkey.org.uk
