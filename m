Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUGGUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUGGUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUGGUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:52:12 -0400
Received: from verein.lst.de ([212.34.189.10]:7356 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265477AbUGGUv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:51:29 -0400
Date: Wed, 7 Jul 2004 22:51:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modular swim3
Message-ID: <20040707205126.GA19308@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040707203934.GA19145@lst.de> <1089233317.2026.37.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089233317.2026.37.camel@gaston>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 03:48:38PM -0500, Benjamin Herrenschmidt wrote:
> On Wed, 2004-07-07 at 15:39, Christoph Hellwig wrote:
> > Needs one magic mediabay symbol exported.  I've also moved the Kconfig
> > entry to where it belongs.
> 
> Hrm... I wouldn't recommend anybody to try to rmmod it though ...

it's doesn't have a module_exit() entry point, so it's unloadable anyway

