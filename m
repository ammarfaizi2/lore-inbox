Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUHBUJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUHBUJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUHBUJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:09:09 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:59802 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262837AbUHBUJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:09:07 -0400
Date: Mon, 2 Aug 2004 13:08:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
Message-ID: <20040802200837.GA25664@taniwha.stupidest.org>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802121635.GE14477@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 02:16:35PM +0200, Arjan van de Ven wrote:

> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for
> irqbalanced I'd like to find out which cpu is the boot cpu, is there
> a good way of doing so ?

cpu numbers are logical not physical, so can't we assume cpu-0 is
*always* the boot cpu?
