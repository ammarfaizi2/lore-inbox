Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272935AbTHKSJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:08:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49580 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272919AbTHKSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:07:36 -0400
Date: Mon, 11 Aug 2003 19:07:03 +0100
From: Dave Jones <davej@redhat.com>
To: Jocelyn Mayer <l_indien@magic.fr>
Cc: linux kernel <linux-kernel@vger.kernel.org>, gregkh@kroah.com
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Message-ID: <20030811180703.GA1564@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jocelyn Mayer <l_indien@magic.fr>,
	linux kernel <linux-kernel@vger.kernel.org>, gregkh@kroah.com
References: <1060429216.29152.61.camel@jma1.dev.netgem.com> <1060624865.29139.137.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060624865.29139.137.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:01:06PM +0200, Jocelyn Mayer wrote:
 > I played with my PC this week-end.
 > First I recompiled XFree up to version 4.3.0. It fixed nothing.
 > I found out that the agpgart/dri drivers failed to init:
 > Linux agpgart interface v0.100 (c) Dave Jones

Did you also compile in any of the AGP chipset drivers?
You should see another AGP line following the above message.
If you built them as modules, make sure you put amd-k7-agp or the like
in your /etc/modules to make sure it gets loaded.

Greg, I'm getting quite a few mails which has been people getting
bitten by this. We discussed this briefly at OLS, what's the missing
piece of the puzzle here, hotplug userspace scripts iirc ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
