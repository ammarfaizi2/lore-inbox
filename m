Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUFLSJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUFLSJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUFLSJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 14:09:25 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:30907 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264883AbUFLSJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 14:09:21 -0400
Date: Sat, 12 Jun 2004 11:09:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040612180918.GA21857@taniwha.stupidest.org>
References: <20040612011129.GD1967@flower.home.cesarb.net> <E1BZBbt-0007jL-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BZBbt-0007jL-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 06:44:01PM +0200, Bernd Eckenfels wrote:

> This is less related to your patch (i like this feature!) but more
> to the current source layout: is there a reason for not sharing
> those open flags on an non architecture specific file?

We just never did it that way, and they are not all the same across
all architectures.

> And should you not try to use the same value on all architectures to
> make that especially easy to change later?

They are ABI specific and will never change.


  --cw
