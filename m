Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVC1PIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVC1PIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVC1PIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:08:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:490 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261841AbVC1PIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:08:32 -0500
Date: Mon, 28 Mar 2005 17:08:32 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH] x86_64/lib: find_first_zero_bit not extern
Message-ID: <20050328150832.GC27906@wotan.suse.de>
References: <20050327213907.3d0a5842.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327213907.3d0a5842.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 09:39:07PM -0800, Randy.Dunlap wrote:
> 
> Exported function was marked inline:
> arch/x86_64/lib/bitops.c:18: warning: `find_first_zero_bit' declared inline afte
> r being called
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

That is already fixed in the patchkit in -mm*

-Andi
