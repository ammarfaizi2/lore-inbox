Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVHYDOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVHYDOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 23:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVHYDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 23:14:25 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:133 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S964776AbVHYDOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 23:14:24 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 24 Aug 2005 20:14:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050825031422.GD6079@taniwha.stupidest.org>
References: <200508232116.j7NLG51g028312@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508232116.j7NLG51g028312@ms-smtp-01.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 05:16:05PM -0400, robotti@godmail.com wrote:

> Also, tar should be an option instead of cpio for the archiver,
> because tar is more widely used.

pretty much everyone will have cpio and it's format is much
simpler/cleaner to deal with

if we want vastly more complex early-userspace semantics i think we
need to carefully decide what is needed and how to put as much of that
logic into userspace rather than hacking this much more in the kernel
for fear of breaking things in subtle ways
