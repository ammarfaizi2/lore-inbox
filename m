Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJaCVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJaCVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJaCVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:21:52 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:18115 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261474AbUJaCVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:21:46 -0400
Date: Sat, 30 Oct 2004 19:21:33 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM Oops
Message-ID: <20041031022133.GA18294@taniwha.stupidest.org>
References: <418428C6.7070707@staff.theuseful.com> <E1CO4dR-0004ZN-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CO4dR-0004ZN-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 02:35:57AM +0100, Bernd Eckenfels wrote:

> Was the snapshot volumne full? I once had oopses in that situation
> (with XFS).

Which version of XFS and when?  The XFS block allocator uses more
stack in low-memory conditions and would over-flow 4K stacks
previously but Nathan made some changes which should make it better.


  --cw
