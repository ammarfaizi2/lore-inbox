Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSGZWn4>; Fri, 26 Jul 2002 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSGZWn4>; Fri, 26 Jul 2002 18:43:56 -0400
Received: from ns.suse.de ([213.95.15.193]:27667 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318601AbSGZWn4>;
	Fri, 26 Jul 2002 18:43:56 -0400
Date: Sat, 27 Jul 2002 00:47:12 +0200
From: Dave Jones <davej@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020727004711.F21176@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
References: <20020726143345.E13656@host110.fsmlabs.com> <20020726233339.D21176@suse.de> <20020726162645.N13656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020726162645.N13656@host110.fsmlabs.com>; from cort@fsmlabs.com on Fri, Jul 26, 2002 at 04:26:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:26:45PM -0600, Cort Dougan wrote:
 > Can you check to make sure for me?  If you stick a 'wall my power changed $*'
 > into /etc/apmd_proxy or /etc/sysconfig/apm-scripts/scripts (or where-ever
 > SuSE puts it) then pull the power from your Vaio what does it give you?  I
 > can get the 'apm' commant to tell me the power state (same with the gnome
 > applets) but apmd is never asynchronously notified.

Ah, I completely misunderstood the problem. The Gnome-applets are
polling, and hence seeing the change I guess.  Your suspicion seems to
be correct, and I was wrong, my z600 needs your patch too.

        Dave (eating words)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
