Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFPFXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTFPFXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:23:15 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:37636 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263355AbTFPFXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:23:14 -0400
Date: Mon, 16 Jun 2003 06:37:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030616063706.A16828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
References: <20030615161009$6dde@gated-at.bofh.it> <20030615174004$76d0@gated-at.bofh.it> <20030615175007$7f59@gated-at.bofh.it> <20030615175012$0573@gated-at.bofh.it> <20030615181004$3663@gated-at.bofh.it> <20030615181010$7f10@gated-at.bofh.it> <20030615182013$7a4e@gated-at.bofh.it> <20030615183011$3fc0@gated-at.bofh.it> <E19RevD-0000jc-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19RevD-0000jc-00@neptune.local>; from der.eremit@email.de on Sun, Jun 15, 2003 at 11:20:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 11:20:19PM +0200, Pascal Schmidt wrote:
> On Sun, 15 Jun 2003 20:30:11 +0200, you wrote in linux.kernel:
> 
> > The only places where this should happen is mounting the rootfs.
> > mount(8) has it's own filesystem type detection code and doesn't
> > call mount(2) unless it found a matching filesystem type.
> 
> Not everybody uses mount(8) from util-linux... I don't think the
> more simplicistic versions in embedded systems will even want to
> do their own type detection. ;)

These mount versions should at least pass down MS_VERBOSE then..

