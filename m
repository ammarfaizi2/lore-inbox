Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVA0SJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVA0SJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVA0SJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:09:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45773 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262402AbVA0SJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:09:21 -0500
Date: Thu, 27 Jan 2005 18:09:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
Message-ID: <20050127180920.GA32380@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125000339.GA610@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125000339.GA610@speedy.student.utwente.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:03:39AM +0100, Sytse Wielinga wrote:
> Hi Andrew,
> 
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > fuse-transfer-readdir-data-through-device.patch
> >   fuse: transfer readdir data through device
> It is great that this is fixed, don't remove it, but it does require the fuse
> libs to be updated at the same time, or opening dirs for listings will break
> like this:

fuse is a new feature, so we'll sort out all issues before it goes to mainline.

I'm sure once it's under review there will be a few more changes in the
kernel <-> userland interface.

