Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTI2RXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTI2RVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:21:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49610 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263874AbTI2RVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:21:07 -0400
Date: Mon, 29 Sep 2003 18:20:46 +0100
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unnecessary checks in pcmcia
Message-ID: <20030929172046.GQ5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1A41Rq-0000NP-00@hardwired> <20030929181901.A7593@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929181901.A7593@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 06:19:01PM +0100, Russell King wrote:
 > On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
 > > io->stop/start are 16 bits, so will never be >0xffff
 > 
 > Not necessarily.  On x86 yes.  On ARM, no.

I recall discussing this with you when I first wrote that patch.
Mind explaining what I've missed ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
