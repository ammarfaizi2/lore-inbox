Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVHNLnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVHNLnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 07:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHNLnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 07:43:22 -0400
Received: from mailfe14.swipnet.se ([212.247.155.161]:37525 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932493AbVHNLnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 07:43:22 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sun, 14 Aug 2005 13:43:18 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Danny ter Haar <dth@picard.cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rcX really this bad ?
Message-ID: <20050814114317.GA1365@localhost.localdomain>
References: <ddn5aa$glm$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddn5aa$glm$1@news.cistron.nl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 10:10:18AM +0000 Danny ter Haar wrote:

> I've posted a couple of times than my newsserver is not stable
> with any 2.6.13-rcX kernels.
> Last kernel that survived is 2.6.12-mm1 (18+days)
> Of course i can just stick with that kernel, but i thought it would
> be wise to live on the edge and run a reasonable loaded server with
> the latest/greatest. This ends in disaster though...
>
> Since i got no feedback on my previous posts, i either bring it 
> the wrong way, or people don't care and i ought to shut up.
> I think however that just before releasing a new stable kernel these
> kind of feedback could be healthy to ironout some bugs.
> 

Is the machine running X? We need some output from it so we can debug
what's going on, the info should be printed to the console. It would
be great if you could run the latest kernel and see if you get any
output. Also add nmi_watchdog=2 to the boot command line.

You can also set up a serial console or netconsole to capture the output
from the server with the help of another machine, described in
Documentation/serial-console.txt
Documentation/networking/netconsole.txt
