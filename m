Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbTILCnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbTILCnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:43:14 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:49097
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261441AbTILCnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:43:12 -0400
Date: Thu, 11 Sep 2003 19:43:09 -0700
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: bttv bug
Message-ID: <20030912024309.GA5534@nasledov.com>
References: <20030910064158.GA19930@nasledov.com> <20030910074123.GH18280@vitelus.com> <3F5F99AD.6080502@vgertech.com> <20030912023814.GA5274@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912023814.GA5274@nasledov.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd also like to mention that the FM radio component still seems to work fine
and that I get a strange error whenever I attempt to access /dev/video0:
(along with the Device or resource busy error)

tuner: TV freq (268435455.93) out of range (44-958)

On Thu, Sep 11, 2003 at 07:38:14PM -0700, Misha Nasledov wrote:
> It seems to work even with the nvidia module loaded, but once I start X, it
> stops working. I thought that perhaps the patch to the nvidia kernel module
> for -test5 was broken, so I used my older 2.6 nvidia kernel module source
> and replaced the call to kdev_val() with MINOR() but that still did not fix
> the problem. I can cat /dev/video0 before starting X, but afterwards it
> says "Device or resouce busy", even after I kill X.
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
