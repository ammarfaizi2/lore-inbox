Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVHZUWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVHZUWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVHZUWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:22:30 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:44679 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1030257AbVHZUW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:22:29 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 26 Aug 2005 13:22:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kent Robotti <dwilson24@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826202226.GA13807@taniwha.stupidest.org>
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com> <20050826190647.GA12296@taniwha.stupidest.org> <20050826200851.GA851@Linux.nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826200851.GA851@Linux.nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 08:08:51PM +0000, Kent Robotti wrote:

> Overmount_rootfs shouldn't take place until you know for sure the
> kernel detects an initramfs.

Actually, it was a deliberate decision to *always* overmount after
some discussion with people.

It's not a clean solution and the overall goals aren't clear here so
it was never submitted for inclusion --- an the fact is 99.9% of users
simply don't need or care for this.

