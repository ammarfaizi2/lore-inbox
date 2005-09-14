Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVINS73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVINS73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVINS73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:59:29 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12940 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932551AbVINS72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:59:28 -0400
Date: Wed, 14 Sep 2005 20:59:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Voegtle <tv@lio96.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forced to CONFIG_PM=y
Message-ID: <20050914185922.GA7516@mars.ravnborg.org>
References: <Pine.LNX.4.61.0509142002130.22437@er-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509142002130.22437@er-systems.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 08:16:10PM +0200, Thomas Voegtle wrote:
> 
> Hello,
> 
> on one computer, which I wanted to switch from 2.6.13 to 2.6.14-rc1 I was
> forced to use CONFIG_PM, look:
> 
> thomas@tv2:~/linux-2.6.14-rc1> zgrep CONFIG_PM /proc/config.gz 
> # CONFIG_PM is not set
> thomas@tv2:~/linux-2.6.14-rc1> zcat /proc/config.gz > .config 
> thomas@tv2:~/linux-2.6.14-rc1> make oldconfig
> ...
> *
> * Power management options (ACPI, APM)
> *
> Power Management support (PM) [Y/?] y
>   Power Management Debug Support (PM_DEBUG) [N/y/?] (NEW) 
> 
> 
> I never had question if I want to have CONFIG_PM, the "y" was already 
> there.
Something else selected CONFIG_PM for you.
Try to see help in menuconfig, here you can see what symbol selected
CONFIG_PM.

	Sam
