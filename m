Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUJDWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUJDWku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUJDWkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:40:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:473 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268529AbUJDWki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:40:38 -0400
Subject: Re: [patch] inotify locking and other misc.
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096913639.17426.29.camel@betsy.boston.ximian.com>
References: <1096865816.3827.1.camel@vertex>
	 <1096913639.17426.29.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Mon, 04 Oct 2004 18:39:05 -0400
Message-Id: <1096929546.4429.0.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 14:13 -0400, Robert Love wrote:

> Attached patch brings inotify-0.12 in line with my tree.  It looks like
> some or all of the crucial locking patch was not merged.

FYI, John, something in here is causing a deadlock.

If you see it please let me know.  I am tracking it down but moving
slowly.

	Robert Love


