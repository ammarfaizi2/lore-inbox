Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVK2VQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVK2VQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVK2VQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:16:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:32942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932404AbVK2VQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:16:04 -0500
Subject: Re: [PATCH][RFC][2.6.15-rc3] snd_powermac: Add ID for Spring 2005
	17" Powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com>
References: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 08:09:53 +1100
Message-Id: <1133298593.16726.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 14:02 -0500, Kyle Moffett wrote:
> The audio chip in my Spring 2005 17" PowerBook was incorrectly  
> recognized as an AWACS chip.  This adds the chip ID to the  
> snd_powermac driver such that it is recognized as a Toonie (I don't  
> know if that's correct, but it's the only one that makes it work at  
> all). and sorts the ID lists numerically.  NOTE:  This chip is only  
> minimally supported at this point; it has system beep support and  
> very low volume speaker output, and that's about it.
> 
> Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

It's a different chip but heh, Toonie might work very basically (Toonie
is basically a non-configurable codec).

Anyway, what is needed is a rewrite of that driver from scratch with a
more flexible architecture to deal with the multiple codecs & busses.

Ben.


