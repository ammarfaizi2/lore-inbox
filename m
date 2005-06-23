Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVFWAQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVFWAQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVFWAOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:14:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48054 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261764AbVFWAMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:12:50 -0400
Date: Thu, 23 Jun 2005 02:12:49 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050623001249.GF14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF96FB1@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230AF96FB1@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 05:07:44PM -0700, YhLu wrote:
> actually with LinuxBIOS I can boot into 8 way dual core system.
> 
> But it will randomly hang. acutally when using 
> cat /proc/interrupts.

Because it needs physical addressing, not logical like it is used right now.
That it works at all is surprising.

-Andi
