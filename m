Return-Path: <linux-kernel-owner+w=401wt.eu-S932678AbWLaCW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWLaCW2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 21:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWLaCW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 21:22:28 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:56369 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbWLaCW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 21:22:28 -0500
Message-ID: <45971F39.4060301@gentoo.org>
Date: Sat, 30 Dec 2006 21:23:53 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
References: <45971053.7040609@lwfinger.net>
In-Reply-To: <45971053.7040609@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger wrote:
> When this commit is reverted, I get sound, but playing a sound file results in about an 0.5 sec
> fragment being replayed over and over forever. If commit 7376d013fc6d3a45..., which is entitled
> "Simple patch to enable Message Signalled Interrupts for the HDA Intel audio controller" is
> reverted, the sound works fine.

MSI is now disabled by default on this driver, so I'm pretty sure you 
only have the first bug talking in terms of the most recent kernels.

Daniel
