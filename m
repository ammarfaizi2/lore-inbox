Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbVINVF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVINVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVINVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:05:28 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:62354 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932716AbVINVF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:05:28 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 14 Sep 2005 14:05:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Sanchez <david.sanchez@lexbox.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Corrupted file on a copy
Message-ID: <20050914210507.GA9336@taniwha.stupidest.org>
References: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 03:14:58PM +0200, David Sanchez wrote:

> I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550
> board.

The 2.6.10 mips kernel has a prefetch bug, make sure that isn't biting
you (it might be there still, I don't recall seeing a fix for it
posted).
