Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUGIIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUGIIgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUGIIgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 04:36:53 -0400
Received: from 154.192.88.213.host.tele1europe.se ([213.88.192.154]:10624 "EHLO
	defiant") by vger.kernel.org with ESMTP id S264577AbUGIIgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 04:36:53 -0400
Date: Fri, 9 Jul 2004 10:36:42 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709083642.GA5121@linux.nu>
Reply-To: erik@rigtorp.com
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708210403.GA18049@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 10:04:03PM +0100, Christoph Hellwig wrote:
> No.  This stuff has no business in the kernel, paint your fancy graphics
> ontop of fbdev.  And the SuSE bootsplash patch is utter crap, I mean what
> do you have to smoke to put a jpeg decoder into the kernel?

Well how are you going to be alble to watch pr0n att kernel boot without a
jpeg decoder? :) The problem is that it's hard to have a X server running
when suspending. An ascii progress bar could work.
