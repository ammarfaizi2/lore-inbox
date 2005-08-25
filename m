Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVHYNtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVHYNtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVHYNte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:49:34 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:39144 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S964989AbVHYNte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:49:34 -0400
X-ORBL: [67.124.117.85]
Date: Thu, 25 Aug 2005 06:49:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050825134931.GB6703@taniwha.stupidest.org>
References: <200508250435.j7P4ZM1g015411@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508250435.j7P4ZM1g015411@ms-smtp-01.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 12:35:22AM -0400, robotti@godmail.com wrote:

> I don't know, because tar is probably more widely used and
> consequently people are more familiar with how to use it.

As I said before, the cpio format is cleaner/easier to parse in the
kernel.  Everyone has cpio probably so using tar isn't necessary.

> But, that is not as important as having the option of using tmpfs
> as the initramfs.

Well, it's not clean that we really want this either.  I have some
niche needs for it but I suspect most people will never use such an
option.
