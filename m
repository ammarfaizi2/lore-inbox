Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVHZTG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVHZTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVHZTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:06:58 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:54146 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1030198AbVHZTG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:06:57 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 26 Aug 2005 12:06:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: dwilson24@nyc.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826190647.GA12296@taniwha.stupidest.org>
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 09:39:15PM -0400, dwilson24@nyc.rr.com wrote:

> Wouldn't it be better to put overmount_rootfs in initramfs.c
> and call it only if there's a initramfs?

I don't see what or how that helps.  Yes we can shuffle some code
about but the real problem still exists.

That is is that (by design) the early userspace is unpacked as soon as
possible before all kernel subsystems are up.
