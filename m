Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUIWS2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUIWS2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:28:39 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:18180 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S268295AbUIWS2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:28:23 -0400
Date: Thu, 23 Sep 2004 19:28:14 +0100
From: Dave Jones <davej@redhat.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>,
       Frank Phillips <fphillips@linuxmail.org>
Subject: Re: 2.6.9-rc2-mm2 vs glxgears
Message-ID: <20040923182814.GB7107@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>,
	Frank Phillips <fphillips@linuxmail.org>
References: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com> <200409230327.11531.gene.heskett@verizon.net> <21d7e997040923011927860bb2@mail.gmail.com> <200409231057.15120.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409231057.15120.gene.heskett@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:57:15AM -0400, Gene Heskett wrote:

 > X-tacy version of an ATI Radeon 9200SE, 128 megs of ram.  And these 
 > lines from messages at about the time I did the startx I've not seen 
 > before:
 > Sep 23 03:19:55 coyote kernel: agpgart: Found an AGP 3.0 compliant 
 > device at 0000:00:00.0.
 > Sep 23 03:19:55 coyote kernel: agpgart: Putting AGP V3 device at 
 > 0000:00:00.0 into 4x mode
 > Sep 23 03:19:55 coyote kernel: agpgart: Putting AGP V3 device at 
 > 0000:02:00.0 into 4x mode
 > Sep 23 03:19:55 coyote kernel: [drm] Loading R200 Microcode
 > 
 > So this is something new with rc2-mm2 (new to me anyway).  The card, 
 > and its mobo socket are supposedly 8X, so why the setting to 4X?

Because X still doesn't support an AGPMode "x8" option yet.

		Dave

