Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTEGJYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbTEGJYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:24:36 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:15370 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263026AbTEGJYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:24:35 -0400
Date: Wed, 7 May 2003 10:37:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Monchi Abbad <kernel@axion.demon.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dvbdev fixes ( /dev/dvb/adapter0demux0 -> /dev/dvb/adapter0/demux0
Message-ID: <20030507103705.A14343@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Monchi Abbad <kernel@axion.demon.nl>, linux-kernel@vger.kernel.org
References: <20030507092222.GA18446@axion.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030507092222.GA18446@axion.demon.nl>; from kernel@axion.demon.nl on Wed, May 07, 2003 at 11:22:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 11:22:22AM +0200, Monchi Abbad wrote:
> I found a mistake in the dvbdev.c file when creating the dvb /devfs files, it created /dev/dvb/adapter0device0 instead of /dev/dvb/adapter0/device0. But here is a simple fix.

Ooops, that was my typo.  Fix looks good, thanks a lot for spotting this.

