Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbUKQTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUKQTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUKQTVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:21:35 -0500
Received: from peabody.ximian.com ([130.57.169.10]:63390 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262460AbUKQTUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:20:21 -0500
Subject: Re: [patch] inotify: vfs_permission was replaced
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041117191803.GA11830@infradead.org>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
	 <1100714560.6280.7.camel@betsy.boston.ximian.com>
	 <20041117190850.GA11682@infradead.org>
	 <1100718601.4981.2.camel@betsy.boston.ximian.com>
	 <20041117191803.GA11830@infradead.org>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 14:17:32 -0500
Message-Id: <1100719052.4981.4.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 19:18 +0000, Christoph Hellwig wrote:

> No it doesn't.  Please try to understand the APIs before you're using them.
> Just looking at the callers should give you an immediate clue.

Maybe you should look at the code in question.  We actually want to
perform the exact same sort of permission checks that, say, read
performs.

	Robert Love


