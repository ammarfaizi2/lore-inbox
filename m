Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUHBULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUHBULn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUHBULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:11:42 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:30879 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262932AbUHBULd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:11:33 -0400
Date: Mon, 2 Aug 2004 13:10:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch for review] BSD accounting IO stats
Message-ID: <20040802201040.GB25664@taniwha.stupidest.org>
References: <m3r7qpsoa4.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0408021509520.25305-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408021509520.25305-100000@dhcp83-102.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:11:27PM -0400, Rik van Riel wrote:

> It may be easier to do this at write(2) time, making the
> assumption that most IO done there will eventually hit
> the filesystem.

but for lots of loads that's not true, consider the case of temporary
files which usually never hit the disk before being unlinked


  --cw
