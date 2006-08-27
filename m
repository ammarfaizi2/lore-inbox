Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWH0SMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWH0SMt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWH0SMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:12:49 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:43195 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S932223AbWH0SMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:12:48 -0400
Date: Sun, 27 Aug 2006 14:12:45 -0400
From: Ian Lindsay <iml@formicary.org>
To: =?unknown-8bit?B?SsO2cm4=?= Engel <joern@wohnheim.fh-wedel.de>,
       fsdevel@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: LogFS
Message-ID: <20060827181245.GA14544@gen.formicary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827171728.GB3502@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  +/* FIXME: This should really be somewhere in the 64bit area. */
> >  +#define LOGFS_LINK_MAX (2^30)

> > Interesting choice of constant.

> Yes.  I didn't spend a long time thinking about whether it should be
> 2^31 or 2^31-1 or 2^31-2.  It will be a while before it becomes an
> issue in real life anyway. :)

So, 28 should be enough for everyone?

