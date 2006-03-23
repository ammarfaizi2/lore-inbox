Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWCWLbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCWLbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWCWLbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:31:22 -0500
Received: from rune.pobox.com ([208.210.124.79]:34720 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750990AbWCWLbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:31:22 -0500
Date: Thu, 23 Mar 2006 05:31:18 -0600
From: Rodney Gordon II <meff@pobox.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.16-ck1
Message-ID: <20060323113118.GA9329@spherenet.spherevision.org>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>
References: <200603202145.31464.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603202145.31464.kernel@kolivas.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good job Con, on your patches.. As far as the kernel in general, I'd
like to post some warnings:

Adaptive readahead: I had probs with this before, and I still do.. On
a desktop if you have odd problems (nothing responding for SECONDS,
very slow disk I/O during heavy I/O, etc..) disable it.

The new Yukon2 "sky2" driver: This one really pissed me off. It had me
thinking apache2 AND my linksys router we're on the brink. For some
unknown reason at least for me, in FF it would only half-load some
pages, including ones on localhost AND my router (10.1.1.1) ... I
dunno what the hell is up with this one. I have to stay with the
syskonnect.com sk98lin patch, which.. doesn't work with 2.6.16 so I am
back to 2.6.15 at the moment.

nVidia drivers: Broken. I posted a ftbfs bug on the debian bts, here
is a current patch that works against the current release:
http://bugs.debian.org/cgi-bin/bugreport.cgi/nvidia-kernel-source_1.0.8178-2.diff?bug=357992;msg=15;att=1

All in all, my experience sucked for the first time on this kernel.

Good luck with this new one..
-r

-- 
Rodney "meff" Gordon II               -*-              meff@pobox.com
Systems Administrator / Coder Geek    -*-       Open yourself to OpenSource
